package classes.command 
{
	import classes.proxy.FreeGameProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	/**
	 * ...
	 * @author Ethan
	 */
	public class FreeGameCommand extends SimpleCommand
	{
		
		public function FreeGameCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void
		{
			var _freeGame:FreeGameProxy = facade.retrieveProxy(FreeGameProxy.NAME) as FreeGameProxy;
			_freeGame.toGetData(AbstractMain.GAME_ID);
		}
		
	}

}