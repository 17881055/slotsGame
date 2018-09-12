package classes.command
{
	import classes.mediator.bottomBar.BtnPlayMediator;
	import classes.mediator.bottomBar.displayView.DisplayBalanceMediator;
	import classes.proxy.BalanceProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BalanceCommand extends SimpleCommand
	{
		public static const UPDATA_BALANCE_COMMAND:String = "updata_balance_command";
		
		public function BalanceCommand()
		{
		
		}
		
		override public function execute(notification:INotification):void
		{
			var _balance:BalanceProxy = facade.retrieveProxy(BalanceProxy.NAME) as BalanceProxy;
			if (notification.getType() == DisplayBalanceMediator.FRIST_START_GAME)
			{
				_balance.toGetData(true);
			}
			else
			{
				_balance.toGetData();
			}
		
		}
	
	}

}