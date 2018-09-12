package classes.mediator.bottomBar.displayView
{
	import classes.mediator.bottomBar.BetBarMediator;
	import classes.mediator.bottomBar.LinesBarMediator;
	import classes.proxy.BetProxy;
	import classes.proxy.vo.BetVo;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class DisplayBetMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DisplayBetMediator";
		static public const BET_CHANGE:String = "betChange";
		private var _betRate:Number;
		private var _lineNum:uint;
		private var _bet:Number;
		
		public function DisplayBetMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
		
		}
		
		public function set bet(value:Number):void
		{
			_bet = Math.round(value * 100) / 100 ;
			displayBetView.text = _bet.toString();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var _bv:BetVo = notification.getBody() as BetVo;
			switch (notification.getName())
			{
				case LinesBarMediator.GIVE_LINE_DATA: 
					_lineNum = _bv.lineNum;
					break;
				case BetBarMediator.GIVE_BET_DATA: 
					_betRate = _bv.betRate;
					break;
			}
			if (_lineNum && _betRate)
			{
				updataBet();
			}
		}
		
		private function updataBet():void
		{
			bet = _lineNum * _betRate;
			var _bv:BetVo = new BetVo();
			_bv.bet = Math.round(_lineNum * _betRate * 100)/100 ;
			_bv.betRate = _betRate;
			_bv.lineNum = _lineNum;
			
			var _bet:BetProxy = facade.retrieveProxy(BetProxy.NAME) as BetProxy;
			_bet.setData(_bv);
			sendNotification(BET_CHANGE);
		}
		
		override public function listNotificationInterests():Array
		{
			return [LinesBarMediator.GIVE_LINE_DATA, BetBarMediator.GIVE_BET_DATA];
		}
		
		private function get displayBetView():TextField
		{
			return viewComponent.__Text as TextField;
		}
	
	}

}