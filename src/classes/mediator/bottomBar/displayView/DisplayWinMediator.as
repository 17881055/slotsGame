package classes.mediator.bottomBar.displayView
{
	import classes.command.RollControlCommand;
	import classes.mediator.middleBar.RollBarMediator;
	import classes.proxy.vo.WinVo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class DisplayWinMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DisplayWinMediator";
		private var _win:Number;
		
		public function DisplayWinMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
			clearWinText();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case RollControlCommand.DISPLAY_WIN_RESET: 
					clearWinText();
					break;
				case RollBarMediator.UPDATA_DISPLAY_WIN_COMMAND: 
					var _wV:WinVo  = notification.getBody() as WinVo;
					winText = _wV.win;
					break;
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [RollControlCommand.DISPLAY_WIN_RESET, RollBarMediator.UPDATA_DISPLAY_WIN_COMMAND];
		}
		
		private function clearWinText():void
		{
			_win = 0;
			WinTextView.text = "";
		}
		
		private function set winText(value:Number):void
		{
			_win = _win + Math.round(value * 100) / 100 ;
			_win = Math.round(_win * 100) / 100 ;
			WinTextView.text = _win.toFixed(2);
		}
		
		private function get WinTextView():TextField
		{
			return viewComponent.__Text as TextField;
		}
		
		private function get displayWinView():MovieClip
		{
			return viewComponent as MovieClip;
		}
	
	}

}