package classes.mediator.middleBar
{
	import flash.display.MovieClip;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class LineDisplayBarMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LineDisplayBarMediator";
		
		public function LineDisplayBarMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
		
		}
		
		override public function handleNotification(notification:INotification):void
		{
		
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		private function get lineDisplayBarView():MovieClip
		{
			return viewComponent as MovieClip;
		}
	
	}

}