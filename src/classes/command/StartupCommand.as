package classes.command
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.MacroCommand;
	


	/**
	 * ...
	 * @author ethan
	 */
	public class StartupCommand extends MacroCommand implements ICommand
	{

		override protected function initializeMacroCommand():void
		{
			
			addSubCommand( InitPrepCommand );
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
			addSubCommand( FreeGameCommand );
			
		}

	}

}