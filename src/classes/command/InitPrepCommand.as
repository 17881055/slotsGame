package classes.command
{
	import classes.mediator.bottomBar.BtnPlayMediator;
	import classes.mediator.bottomBar.displayView.DisplayBalanceMediator;
	import classes.mediator.bottomBar.displayView.DisplayFreeGameMediator;
	import classes.mediator.middleBar.RollBarMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author ethan
	 */
	public class InitPrepCommand extends SimpleCommand
	{
		
		public function InitPrepCommand()
		{
		
		}
		
		override public function execute(notification:INotification):void
		{
			//15
			facade.registerCommand(BtnPlayMediator.REQUEST_START_ROLL_COMMAND, RollControlCommand);
			facade.registerCommand(BtnPlayMediator.REQUEST_STOP_ROLL_COMMAND, RollControlCommand);
			facade.registerCommand(RollBarMediator.ROLLING_START_PROCESSING, RollControlCommand);
			facade.registerCommand(RollBarMediator.ROLL_OVER_EVENT, RollControlCommand);
			facade.registerCommand(DisplayBalanceMediator.REQUEST_BALANCE_DATA_COMMAND, BalanceCommand);
			facade.registerCommand(RollBarMediator.REQUEST_BALANCE_DATA_COMMAND, BalanceCommand);
			facade.registerCommand(DisplayFreeGameMediator.REQUEST_FREEGAME_DATA_COMMAND, FreeGameCommand);
			
		}
	
	}

}