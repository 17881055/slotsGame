package classes.mediator.topBar
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	import classes.proxy.JackpotProxy;
	import classes.proxy.vo.JackpotVo;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * ...
	 * @author Ethan
	 */
	public class TopBarMediator extends Mediator implements IMediator
	{
		public static const NAME:String="TopBarMediator";

		private static const GET_TIME:int=120;
		private static const GET_SPEED:int=1000;
		private var _numSmall:Number;
		private var _numMiddle:Number;
		private var _numBig:Number;
		private var _timer:Timer;
		private var _num:int=0;

		public function TopBarMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			init();
		}

		private function init():void
		{
			//第一次取数据延迟500
			formatJackpot();
			formatXbutton();
			var _to:uint=setTimeout(getData, 500);
			_timer=new Timer(GET_SPEED, GET_TIME);
			_timer.addEventListener(TimerEvent.TIMER, enterFrame);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, overTime);
			_timer.start();

		}

		/**
		 * 格式化1-5倍按钮
		 *
		 */
		private function formatXbutton():void
		{
			button_1xView.gotoAndStop(1);
			button_2xView.gotoAndStop(1);
			button_3xView.gotoAndStop(1);
			button_4xView.gotoAndStop(1);
			button_5xView.gotoAndStop(1);

		}

		//1.4.0
		private function formatJackpot():void
		{
			_numSmall=100.01;
			_numMiddle=500.08;
			_numBig=300.04;
		}

		private function getData():void
		{
			var _jackProxy:JackpotProxy=facade.retrieveProxy(JackpotProxy.NAME) as JackpotProxy;
			_jackProxy.toGetData();
		}

		override public function handleNotification(notification:INotification):void
		{
			var _jp:JackpotVo=notification.getBody() as JackpotVo;
			if (_jp.smallNum && _jp.middleNum && _jp.bigNum)
			{
				_numSmall=Number(_jp.smallNum);
				updatesSmallJackpot();
				_numMiddle=Number(_jp.middleNum);
				updatesMiddleJackpot();
				_numBig=Number(_jp.bigNum);
				updatesBigJackpot();
			}
		}

		override public function listNotificationInterests():Array
		{
			return [JackpotProxy.GIVE_JACKPOT_DATA];
		}

		private function overTime(e:TimerEvent):void
		{
			_timer.reset();
			_timer.start();
			getData();
		}

		//1.4.1
		private function enterFrame(e:TimerEvent):void
		{
			_num++;
			if (_num % 5 == 0)
			{
				updatesSmallJackpot();
			}
			if (_num % 10 == 0)
			{
				updatesBigJackpot();
			}
			if (_num % 1 == 0)
			{
				updatesMiddleJackpot();
			}


		}

		private function updatesBigJackpot():void
		{
			if (_numBig < 10000.00)
			{
				_numBig+=0.01;
			}
			else
			{
				_numBig=10000.00;
			}
			jackpotBigDisplayView.text=_numBig.toFixed(2);
		}

		private function updatesMiddleJackpot():void
		{
			if (_numMiddle < 25000.00)
			{
				_numMiddle+=0.01;
			}
			else
			{
				_numMiddle=25000.00;
			}
			jackpotMiddleDisplayView.text=_numMiddle.toFixed(2);
		}

		private function updatesSmallJackpot():void
		{
			if (_numSmall < 5000.00)
			{
				_numSmall+=0.01;
			}
			else
			{
				_numSmall=5000.00;
			}
			jackpotSmallDisplayView.text=_numSmall.toFixed(2);
		}

		private function get topBarView():Sprite
		{
			return viewComponent as Sprite;
		}

		private function get jackpotSmallDisplayView():TextField
		{
			return topBarView.getChildByName("__JackPotSmallDisplay") as TextField;
		}

		private function get jackpotMiddleDisplayView():TextField
		{
			return topBarView.getChildByName("__JackPotMiddleDisplay") as TextField;
		}

		private function get jackpotBigDisplayView():TextField
		{
			return topBarView.getChildByName("__JackPotBigDisplay") as TextField;
		}

		private function get button_1xView():MovieClip
		{
			return topBarView.getChildByName("__Button_1X") as MovieClip;
		}

		private function get button_2xView():MovieClip
		{
			return topBarView.getChildByName("__Button_2X") as MovieClip;
		}

		private function get button_3xView():MovieClip
		{
			return topBarView.getChildByName("__Button_3X") as MovieClip;
		}

		private function get button_4xView():MovieClip
		{
			return topBarView.getChildByName("__Button_4X") as MovieClip;
		}

		private function get button_5xView():MovieClip
		{
			return topBarView.getChildByName("__Button_5X") as MovieClip;
		}

	}

}
