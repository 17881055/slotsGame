package classes.mediator.middleBar
{
	import classes.proxy.vo.WinVo;
	import flash.display.MovieClip;
	import flash.utils.setTimeout;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class WinJackpotMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "WinJackpotMediator";
		private static const JACKPOT:String = "jackpot";
		private static const JACKPOT_CASH_A:String = "jackpotCashA";
		private static const JACKPOT_CASH_B:String = "jackpotCashB";
		private static const JACKPOT_CASH_C:String = "jackpotCashC";
		private static const NORMAL:String = "normal";
		static public const REST:String = "rest";
		static public const SHOW:String = "show";
		static public const SHOW_JACKPOT_CASH_A:String = "showJackpotCashA";
		static public const SHOW_JACKPOT_CASH_B:String = "showJackpotCashB";
		static public const SHOW_JACKPOT_CASH_C:String = "showJackpotCashC";
		static public const OVER:String = "over";
		
		public function WinJackpotMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			winJackpotView.gotoAndStop(NORMAL);
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case WinJackpotMediator.SHOW_JACKPOT_CASH_A: 
					showWinJackpotCashA();
					break;
				case WinJackpotMediator.SHOW_JACKPOT_CASH_B: 
					showWinJackpotCashB();
					break;
				case WinJackpotMediator.SHOW_JACKPOT_CASH_C: 
					showWinJackpotCashC();
					break;
				case WinJackpotMediator.SHOW: 
					showWinJackpot(notification.getBody() as WinVo);
					break;
				case WinJackpotMediator.REST: 
					hideWinJackpot();
					break;
			
			}
		}
		//1.4.1
		private function showWinJackpotCashC():void 
		{
			winJackpotView.gotoAndPlay(JACKPOT_CASH_C);
			//声音
			setTimeout(showOver, 20000); //显示延迟
		}
		//1.4.1
		private function showWinJackpotCashB():void 
		{
			winJackpotView.gotoAndPlay(JACKPOT_CASH_B);
			//声音
			setTimeout(showOver, 20000); //显示延迟
		}
		//1.4.1
		private function showWinJackpotCashA():void 
		{
			winJackpotView.gotoAndPlay(JACKPOT_CASH_A);
			//声音
			setTimeout(showOver, 20000); //显示延迟
		}
		//1.4.1
		private function showWinJackpot(value:WinVo):void
		{
			winJackpotView.gotoAndPlay(JACKPOT);
			var _jackpot:String = value.win.toString();
			winJackpotView.__jackpotTEXT.__text.text = 'Jackpot ' + _jackpot;
			//声音
			setTimeout(showOver, 20000);//显示延迟
		}
		
		private function showOver():void
		{
			hideWinJackpot();
			sendNotification(OVER);
		}
		
		private function hideWinJackpot():void
		{
			winJackpotView.gotoAndStop(NORMAL);
		}
		
		override public function listNotificationInterests():Array
		{
			return [WinJackpotMediator.SHOW, WinJackpotMediator.REST,WinJackpotMediator.SHOW_JACKPOT_CASH_A,WinJackpotMediator.SHOW_JACKPOT_CASH_B,WinJackpotMediator.SHOW_JACKPOT_CASH_C];
		}
		
		public function get winJackpotView():Object
		{
			return viewComponent as MovieClip;
		}
	
	}

}