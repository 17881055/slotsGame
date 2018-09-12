package classes.command
{
	
	import classes.proxy.BalanceProxy;
	import classes.proxy.BetProxy;
	import classes.proxy.FreeGameProxy;
	import classes.proxy.JackpotProxy;
	import classes.proxy.PlayStateProxy;
	import classes.proxy.ResultProxy;
	import classes.proxy.RollStateProxy;
	import classes.proxy.SaveFreeGameProxy;
	import classes.proxy.SetResultProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.MacroCommand;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author ethan
	 */
	public class ModelPrepCommand extends SimpleCommand
	{
		
		override public function execute(notification:INotification):void
		{
			facade.registerProxy(new BetProxy(BetProxy.NAME));
			facade.registerProxy(new JackpotProxy(JackpotProxy.NAME));
			facade.registerProxy(new BalanceProxy(BalanceProxy.NAME));
			facade.registerProxy(new PlayStateProxy(PlayStateProxy.NAME));
			facade.registerProxy(new ResultProxy(ResultProxy.NAME));
			facade.registerProxy(new SetResultProxy(SetResultProxy.NAME));
			facade.registerProxy(new RollStateProxy(RollStateProxy.NAME));
			facade.registerProxy(new FreeGameProxy(FreeGameProxy.NAME));
			facade.registerProxy(new SaveFreeGameProxy(SaveFreeGameProxy.NAME));
			
		}
	
	}

}