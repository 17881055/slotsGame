package classes.mediator.bottomBar
{
	import classes.command.RollControlCommand;
	import classes.mediator.bottomBar.displayView.DisplayBetMediator;
	import classes.mediator.middleBar.RollBarMediator;
	import classes.proxy.BalanceProxy;
	import classes.proxy.BetProxy;
	import classes.proxy.PlayStateProxy;
	import classes.proxy.RollStateProxy;
	import classes.proxy.vo.BalanceVo;
	import classes.proxy.vo.BetVo;
	import classes.proxy.vo.PlayStateVo;
	import classes.proxy.vo.RollVo;
	import classes.utli.UtliAutoPlayMouseEvent;
	import classes.utli.UtliSoundManage;
	import classes.utli.UtliSpinMouseEvent;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BtnPlayMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BtnPlayMediator";
		public static const REQUEST_START_ROLL_COMMAND:String = "request_start_roll_command";
		public static const REQUEST_STOP_ROLL_COMMAND:String = "request_stop_roll_command";
		private var _isAutoPlay:Boolean;
		private var _spinBtn:UtliSpinMouseEvent;
		private var _autoPlayBtn:UtliAutoPlayMouseEvent;
		private var _sound:UtliSoundManage;
		
		public function BtnPlayMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		
		private function init():void
		{
			_sound = UtliSoundManage.getInstance();
			_spinBtn = new UtliSpinMouseEvent(btnSpinView, startRoll, stopRoll);
			_autoPlayBtn = new UtliAutoPlayMouseEvent(btnAutoplayView, startAutoPlayRoll, stopAutoPlayRoll);
			_spinBtn.start();
			_autoPlayBtn.start();
		}
		
		
		
		//关闭自动滚动
		private function stopAutoPlayRoll(value:MovieClip):void
		{
			var _psp:PlayStateProxy = facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			_psp.toManuallyPlayState();
		
		}
		
		//开启自动滚动
		private function startAutoPlayRoll(value:MovieClip):void
		{
			_sound.autoPlaySound.play();
			var _psp:PlayStateProxy = facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			_psp.toAutoPlayState();
			if (!_isAutoPlay)
			{
				_isAutoPlay = true;
				sendNotification(REQUEST_START_ROLL_COMMAND);
				_spinBtn.unable();
			}
		}
		
		//全部停止
		private function clearAll(value:MovieClip):void
		{
			var _psp:PlayStateProxy = facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			_psp.toStopState();
		}
		
		//停止滚动
		private function stopRoll(value:MovieClip):void
		{
			sendNotification(REQUEST_STOP_ROLL_COMMAND);
		}
		
		//开始滚动
		private function startRoll(value:MovieClip):void
		{
			var _psp:PlayStateProxy = facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			_psp.toManuallyPlayState();
			sendNotification(REQUEST_START_ROLL_COMMAND);
			_autoPlayBtn.unable();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case RollControlCommand.CONTINUE_PLAY_COMMAND: 
					_isAutoPlay = false;
					//_spinBtn.start();
					//_autoPlayBtn.start();
					break;
				case DisplayBetMediator.BET_CHANGE: //bet 发生改变
				case BalanceProxy.GIVE_BALANCE_DATA: 
					var _bet:BetProxy = facade.retrieveProxy(BetProxy.NAME) as BetProxy;
					var _betV:BetVo = _bet.getData() as BetVo; // 取当时的赔率
					var _balance:BalanceProxy = facade.retrieveProxy(BalanceProxy.NAME) as BalanceProxy;
					var _balanceV:BalanceVo = _balance.getData() as BalanceVo; // 取当时的分数
					//判断是否在转动
					var _rollP:RollStateProxy = facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy;
					var _rV:RollVo = _rollP.getData() as RollVo;
					var _psp:PlayStateProxy = facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
					var _pVO:PlayStateVo = _psp.getData() as PlayStateVo;
					
					//发送更新Balance命令
					if (!_rV.isRolling)
					{
						//trace("GIVE_BALANCE_DATA");
						//修改4
						// 10.28 修改
						if (_balanceV.balance < _betV.bet || _betV.bet < 0)
						{
							//trace("GIVE_BALANCE_DATA_1");
							_autoPlayBtn.unable();
							_spinBtn.unable();
							
							
						}
						else
						{
							//trace("GIVE_BALANCE_DATA_2");
							if (!_isAutoPlay && !_pVO.isfreegamePlay)
							{
								//trace("继续");
								//trace("GIVE_BALANCE_DATA_2_1");
								_spinBtn.start();
								_autoPlayBtn.start();
								_isAutoPlay = false;
								//sendNotification(RollControlCommand.OPEN_LINE_COMMAND); //开启 line
								//sendNotification(RollControlCommand.OPEN_BET_OPERATE_COMMAND); //开启 BET 按纽
							}
						}
						
						if (!_isAutoPlay && !_pVO.isfreegamePlay)
							{
								sendNotification(RollControlCommand.OPEN_LINE_COMMAND); //开启 line
								sendNotification(RollControlCommand.OPEN_BET_OPERATE_COMMAND); //开启 BET 按纽
							}
					}
					break;
				case RollControlCommand.UNABLE_PLAY_COMMAND: 
					_autoPlayBtn.unable();
					_spinBtn.unable();
					_isAutoPlay = false;
					break;
				case RollBarMediator.STOP_MANUALLY_STOP_ROLL_COMMAND: 
					_spinBtn.unable();
					break;
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [BalanceProxy.GIVE_BALANCE_DATA, 
				RollControlCommand.CONTINUE_PLAY_COMMAND, //继续玩信息
				RollControlCommand.UNABLE_PLAY_COMMAND, //不够分，不能玩信息
				RollBarMediator.STOP_MANUALLY_STOP_ROLL_COMMAND, 
				DisplayBetMediator.BET_CHANGE];
		}
		
		private function get btnAutoplayView():MovieClip
		{
			return viewComponent.__BtnAutoplay as MovieClip;
		}
		
		private function get btnSpinView():MovieClip
		{
			return viewComponent.__BtnSpin as MovieClip;
		}
		
		private function get btnPlayView():MovieClip
		{
			return viewComponent as MovieClip;
		}
	}
}