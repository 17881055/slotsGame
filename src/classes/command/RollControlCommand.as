package classes.command
{
	import classes.mediator.bottomBar.BtnPlayMediator;
	import classes.mediator.middleBar.RollBarMediator;
	import classes.proxy.BalanceProxy;
	import classes.proxy.BetProxy;
	import classes.proxy.PlayStateProxy;
	import classes.proxy.vo.BalanceVo;
	import classes.proxy.vo.BetVo;
	import classes.proxy.vo.PlayStateVo;
	import flash.utils.getTimer;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class RollControlCommand extends SimpleCommand
	{
		public static const START_ROLL_COMMAND:String = "start_roll_command";
		public static const STOP_ROLL_COMMAND:String = "stop_roll_command";
		public static const CLOSE_LINE_OPERATE_COMMAND:String = "close_line_operate_command";
		public static const OPEN_LINE_COMMAND:String = "open_line_command";
		public static const CLOSE_BET_OPERATE_COMMAND:String = "close_bet_operate_command";
		public static const OPEN_BET_OPERATE_COMMAND:String = "open_bet_operate_command";
		public static const DEDUCTION_BALANCE_COMMAND:String = "deduction_balance_command";
		public static const CONTINUE_PLAY_COMMAND:String = "continue_play_command";
		public static const UNABLE_PLAY_COMMAND:String = "unable_play_command";
		public static const DISPLAY_WIN_RESET:String = "displayWinReset";
		
		override public function execute(notification:INotification):void
		{
			switch (notification.getName())
			{
				case BtnPlayMediator.REQUEST_START_ROLL_COMMAND: 
					startRoll();
					break;
				case BtnPlayMediator.REQUEST_STOP_ROLL_COMMAND: 
					stopRoll();
					break;
				case RollBarMediator.ROLLING_START_PROCESSING: 
					//扣分
					sendNotification(DEDUCTION_BALANCE_COMMAND);
					break;
				case RollBarMediator.ROLL_OVER_EVENT: //接受停止信息
					//判断是否够分
					var _bet:BetProxy = facade.retrieveProxy(BetProxy.NAME) as BetProxy;
					var _betV:BetVo = _bet.getData() as BetVo;
					var _balance:BalanceProxy = facade.retrieveProxy(BalanceProxy.NAME) as BalanceProxy;
					var _balanceV:BalanceVo = _balance.getData() as BalanceVo;
					//trace("balance:",_balanceV.balance, " bet" ,_betV.bet);
					if (_balanceV.balance >= _betV.bet)
					{ ////够分
						//trace("够分");
						//是否AutoPlay
						var _psp:PlayStateProxy = facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
						var _pV:PlayStateVo = _psp.getData() as PlayStateVo;
						if (_pV.isAutoPlay)
						{ ////是
							///////发送继续玩信息	
							startRoll();
						}
						else
						{ ////否
							
							//openLineAndBet();
							//////发送滚动停止信息&&开启LINE_BTN 点击&& bet点击&& line 点击
							//trace("CONTINUE_PLAY_COMMAND");
							sendNotification(CONTINUE_PLAY_COMMAND);
							
						}
					}
					else
					{ ////不够分
						//trace("不够分");
						openLineAndBet();
						////发送不能玩模式信息&&开启LINE_BTN 点击&& bet点击&& line 点击
						sendNotification(UNABLE_PLAY_COMMAND);
						
					}
					break;
			}
		}
		
		private function openLineAndBet():void
		{ //开启LINE_BTN 点击&& bet点击&& line 点击
			//trace("开启LINE_BTN 点击&& bet点击&& line 点击");
			sendNotification(OPEN_LINE_COMMAND); //开启 line
			sendNotification(OPEN_BET_OPERATE_COMMAND); //开启 BET 按纽
		}
		
		private function stopRoll()
		{
			sendNotification(STOP_ROLL_COMMAND);
		}
		
		private function startRoll():void
		{
			sendNotification(START_ROLL_COMMAND);
			//关闭 line
			sendNotification(CLOSE_LINE_OPERATE_COMMAND);
			//关闭 BET 按纽
			sendNotification(CLOSE_BET_OPERATE_COMMAND);
			//////更新win display 归 0
			sendNotification(DISPLAY_WIN_RESET);
			
		}
	
	}

}