package classes.mediator.bottomBar.displayView
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import classes.mediator.middleBar.RollBarMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class DisplayBackgroundMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DisplayBackgroundMediator";
		public static const BLACK:String = "black";
		public static const RED:String = "red";
		
		public function DisplayBackgroundMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
			setState(BLACK);
		}
		
		private function setState(value:String):void
		{
			if (value == BLACK )
			{
				redBackgroundView.visible= false;
				blackBackgroundView.visible=true;
			}else if( value == RED){
				
				blackBackgroundView.visible=false;
				redBackgroundView.visible=true;
			}
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var _s:String = notification.getBody() as String;
			setState(_s);
		}
		
		override public function listNotificationInterests():Array
		{
			return [RollBarMediator.UPDATA_DISPLAY_BACKGROUND_COMMAND];
		}
		
		private function get redBackgroundView():MovieClip{
			return displayBackgroundView.getChildByName("__red") as MovieClip;
		}
		
		private function get blackBackgroundView():MovieClip{
			return displayBackgroundView.getChildByName("__black") as MovieClip;
		}
		
		
		private function get displayBackgroundView():Sprite
		{
			return viewComponent as Sprite;
		}
	}

}