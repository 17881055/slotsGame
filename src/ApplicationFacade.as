package 
{
	import classes.command.StartupCommand;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * ...
	 * @author ethan
	 */
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const STARTUP : String = "startup";
		
		public static function getInstance() : ApplicationFacade
		{
			if ( instance == null )
				instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController() : void
		{
			super.initializeController();
			registerCommand( STARTUP ,  StartupCommand );
		}
		
		public function startup( stage : Object ) : void
		{
			sendNotification( STARTUP ,  stage );
		}
	
	}

}