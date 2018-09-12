package classes.mediator.bottomBar
{
	import classes.utli.UtliMouseClick;
	import flash.display.MovieClip;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BtnHelpMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BtnHelpMediator";
		static public const SHOW_HELP:String = "showHelp";
		public function BtnHelpMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
			UtliMouseClick.setup(btnHelpView, onMouseEventHandler);
		}
		
		private function onMouseEventHandler(value:MovieClip):void
		{
			//修改4
			sendNotification(SHOW_HELP);
		}
		
		override public function handleNotification(notification:INotification):void
		{
		
		}
		
		private function get btnHelpView():MovieClip
		{
			return viewComponent as MovieClip;
		}
	
	}

}