package classes.mediator.bottomBar.displayView 
{
	import classes.mediator.middleBar.RollBarMediator;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	/**
	 * ...
	 * @author Ethan
	 */
	public class DisplayFreeGameMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DisplayFreeGameMediator";
		static public const REQUEST_FREEGAME_DATA_COMMAND:String = "requestFreegameDataCommand";
		private var _freeGameNum:uint = 0;
		public function DisplayFreeGameMediator(mediatorName:String = null, viewComponent:Object = null) 
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void 
		{
			freeGameText = 0;
			
		}
		
		private function set freeGameText(value:uint):void
		{
			_freeGameNum = value;
			displayFreeGameTextView.text = "FREE SPIN : " + _freeGameNum.toString();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			freeGameText = uint(notification.getBody());
		}
		
		override public function listNotificationInterests():Array
		{
			return [RollBarMediator.UPDATA_DISPLAY_FREEGAME_COMMAND];
		}
		
		private function get displayFreeGameTextView():TextField
		{
			return viewComponent.__Text as TextField;
		}
		
		private function get displayFreeGameView():MovieClip
		{
			return viewComponent as MovieClip;
		}
		
	}

}