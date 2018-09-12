package classes.mediator.bottomBar.displayView
{
	import classes.command.RollControlCommand;
	import classes.proxy.BalanceProxy;
	import classes.proxy.BetProxy;
	import classes.proxy.FreeGameProxy;
	import classes.proxy.RollStateProxy;
	import classes.proxy.vo.BalanceVo;
	import classes.proxy.vo.BetVo;
	import classes.proxy.vo.RollVo;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class DisplayBalanceMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DisplayBalanceMediator";
		public static const REQUEST_BALANCE_DATA_COMMAND:String = "request_balance_data_command";
		public static const FRIST_START_GAME:String = "frist_start_game";
		static public const START_TIMER:String = "startTimer";
		private var timer:Timer;
		private var _balance:Number;
		
		
		public function DisplayBalanceMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
		}
		
		private function init():void
		{
			balance = 0;
			
			sendNotification(DisplayBalanceMediator.REQUEST_BALANCE_DATA_COMMAND,null,FRIST_START_GAME);
			
			
			timer = new Timer(5000, 0);
			timer.addEventListener(TimerEvent.TIMER, ontimerHandler);
			
			
			//timer.start();
		}
		
		override public function onRegister():void
		{
			init();
		}
		
		private function ontimerHandler(e:TimerEvent):void
		{
			//判断是否在转动
			var _rollP:RollStateProxy = facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy; 
			var _rV:RollVo = _rollP.getData() as RollVo;
			//发送更新Balance命令
			if (!_rV.isRolling)
			{
				sendNotification(DisplayBalanceMediator.REQUEST_BALANCE_DATA_COMMAND);
			}
		}
		
		public function set balance(value:Number):void
		{
			_balance = Math.round(value * 100) / 100 ;
			displayBalanceView.text = _balance.toFixed(2);
			
		}
		
		//1.4.0
		override public function handleNotification(notification:INotification):void
		{
			var _bV:BalanceVo = notification.getBody() as BalanceVo;
			switch (notification.getName())
			{
				case RollControlCommand.DEDUCTION_BALANCE_COMMAND: 
					//扣分
					var _bet:BetProxy = facade.retrieveProxy(BetProxy.NAME) as BetProxy;
					var _betV:BetVo = _bet.getData() as BetVo;
					var _balanceProxy:BalanceProxy = facade.retrieveProxy(BalanceProxy.NAME) as BalanceProxy;
					var _nbV:BalanceVo = new BalanceVo();
					balance = _balance - _betV.bet;
					_nbV.balance = _balance;
					//trace(_nbV.balance);
					_balanceProxy.setData(_nbV);
					break;
				case BalanceProxy.GIVE_BALANCE_DATA: 
					var _rollP:RollStateProxy = facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy;
					var _rV:RollVo = _rollP.getData() as RollVo;
					if (!_rV.isRolling) {
						balance = _bV.balance;
						//修改4
						//////更新win display 归 0
						//sendNotification(RollControlCommand.DISPLAY_WIN_RESET);
					}
					break;
				case FreeGameProxy.GIVE_FREEGAME_DATA:
					
					break;
				case BalanceProxy.GIVE_FRIST_BALANCE_DATA:
					
					balance = _bV.balance;
					break;
				case DisplayBalanceMediator.START_TIMER:
					timer.start();
					break;
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [DisplayBalanceMediator.START_TIMER,BalanceProxy.GIVE_BALANCE_DATA, RollControlCommand.DEDUCTION_BALANCE_COMMAND,FreeGameProxy.GIVE_FREEGAME_DATA,BalanceProxy.GIVE_FRIST_BALANCE_DATA];
		}
		
		private function get displayBalanceView():TextField
		{
			return viewComponent.__Text as TextField;
		}
	
	}

}