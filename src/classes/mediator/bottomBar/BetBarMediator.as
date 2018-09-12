package classes.mediator.bottomBar
{
	import classes.command.RollControlCommand;
	import classes.proxy.FreeGameProxy;
	import classes.proxy.vo.BetVo;
	import classes.proxy.vo.FreeGameVo;
	import classes.utli.UtliMouseEvent;
	import classes.utli.UtliSoundManage;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BetBarMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BetBarMediator";
		public static const GIVE_BET_DATA:String = "give_bet_data";
		private var _betAddBtn:UtliMouseEvent;
		private var _betSubBtn:UtliMouseEvent;
		private var _bets:Vector.<Number>;
		private var _pointer:uint;
		private var _currentBetRate:Number;
		private static var MaxBetRate:Number;
		private static var MinBetRate:Number;
		
		public function BetBarMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
			_betAddBtn = new UtliMouseEvent(betAddBtn, onMouseClickHandler);
			_betSubBtn = new UtliMouseEvent(betSubtractBtn, onMouseClickHandler);
		
			//修改4
			_bets = new <Number>[0.02,0.03,0.04,0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.25, 0.5, 1, 2.5, 5];
			MaxBetRate = _bets[_bets.length - 1];
			MinBetRate = _bets[0];
			//修改4
			//指针
			_pointer = 1;
			//当前赔率
			currentBetRate = _pointer;
			stopMouseEvent();
		}
		
		private function onMouseClickHandler(target:MovieClip):void
		{
			var _us:UtliSoundManage = UtliSoundManage.getInstance();
			switch (target.name)
			{
				case "__BtnBetAdd": 
					_pointer++;
					//sound
					_us.addSound.play();
					break;
				case "__BtnBetSubtract": 
					_pointer--;
					//sound
					_us.subSound.play();
					break;
			}
			currentBetRate = _pointer;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			switch (notification.getName())
			{
				case RollControlCommand.CLOSE_BET_OPERATE_COMMAND: 
					stopMouseEvent();
					break;
				case RollControlCommand.OPEN_BET_OPERATE_COMMAND: 
					startMouseEvent();
					break;
				case FreeGameProxy.GIVE_FREEGAME_DATA:
					var _freeGame:FreeGameProxy = facade.retrieveProxy(FreeGameProxy.NAME) as FreeGameProxy;
					var _fg:FreeGameVo = _freeGame.getData() as FreeGameVo;
					//当前赔率
					_pointer =_bets.indexOf( _fg.bet)+1;
					currentBetRate = _pointer;
					stopMouseEvent();
					break;
			}
		}
		
		private function startMouseEvent():void
		{
			if (_betAddBtn.isClick)
				_betAddBtn.ableClick();
			if (_betSubBtn.isClick)
				_betSubBtn.ableClick();
		
		}
		
		private function stopMouseEvent():void
		{
			_betAddBtn.stopClick();
			_betSubBtn.stopClick();
		}
		
		override public function listNotificationInterests():Array
		{
			return [RollControlCommand.CLOSE_BET_OPERATE_COMMAND, RollControlCommand.OPEN_BET_OPERATE_COMMAND,FreeGameProxy.GIVE_FREEGAME_DATA];
		}
		
		private function set currentBetRate(value:uint):void
		{
			_currentBetRate = _bets[value - 1];
			if (_currentBetRate == MaxBetRate)
			{
				_betAddBtn.isClick = false;
				_betAddBtn.stopClick();
			}
			else
			{
				_betAddBtn.isClick = true;
				_betAddBtn.ableClick();
			}
			if (_currentBetRate == MinBetRate)
			{
				_betSubBtn.isClick = false;
				_betSubBtn.stopClick();
			}
			else
			{
				_betSubBtn.isClick = true;
				_betSubBtn.ableClick();
			}
			betRateDisplay.text = _currentBetRate + ' Bet Per Line';
			//send Updata
			var _bv:BetVo = new BetVo();
			_bv.betRate = _currentBetRate;
			sendNotification(GIVE_BET_DATA, _bv);
		}
		
		private function get betRateDisplay():TextField
		{
			return viewComponent.__Bet as TextField;
		}
		
		private function get betAddBtn():MovieClip
		{
			return viewComponent.__BtnBetAdd as MovieClip;
		}
		
		private function get betSubtractBtn():MovieClip
		{
			return viewComponent.__BtnBetSubtract as MovieClip;
		}
		
		private function get betBaView():MovieClip
		{
			return viewComponent as MovieClip;
		}
	
	}

}