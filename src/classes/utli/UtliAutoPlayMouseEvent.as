package classes.utli
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliAutoPlayMouseEvent
	{
		private const AUTOPLAY_ON:String = "normal"; // 可点击切换为StopAutoplay滚动;有点击事件
		private const AUTOPLAY_OFF:String = "down"; //默认状态//Spin;不能点击时使用; balance不够;freeGame;去除点击事件;
		private const STOP_ON:String = "stop"; // 可点击切换为Autoplay;有点击事件
		private var _autoPlayClickFunc:Function;
		private var _stopAutoPlayClickFunc:Function;
		private var _target:MovieClip;
		private var _dic:Dictionary;
		
		public function UtliAutoPlayMouseEvent(value:MovieClip, autoPlayClickFunc:Function, stopAutoPlayClickFunc:Function)
		{
			
			_autoPlayClickFunc = autoPlayClickFunc;
			_stopAutoPlayClickFunc = stopAutoPlayClickFunc;
			_target = value;
			init();
		
		}
		
		private function init():void
		{
			_dic = new Dictionary(true);
			unable();
		}
		
		//注册事件
		private function addEventFn(type:String, func:Function, name:String):void
		{
			_dic[name] = func;
			_target.addEventListener(type, func);
		}
		
		//删除事件
		private function delEventFn(type:String, name:String):void
		{
			_target.removeEventListener(type, _dic[name]);
		}
		
		//删除所有事件
		private function delAllEvent(type:String):void
		{
			for each (var _f:Function in _dic)
			{
				_target.removeEventListener(type, _f);
			}
		}
		
		// AUTOPLAY_ON
		//1.4.0
		public function start():void
		{
			if (_target.currentFrameLabel != AUTOPLAY_ON)
			{
				_target.buttonMode = true;
				addEventFn(MouseEvent.CLICK, onStartHandler, AUTOPLAY_ON);
				_target.gotoAndStop(AUTOPLAY_ON);
			}
		}
		
		public function unable():void
		{
			_target.buttonMode = false;
			_target.gotoAndStop(AUTOPLAY_OFF);
			delAllEvent(MouseEvent.CLICK);
		}
		
		//STOP_ON
		private function stop():void
		{
			addEventFn(MouseEvent.CLICK, onStopHandler, STOP_ON);
			_target.gotoAndStop(STOP_ON);
		}
		
		private function onStartHandler(e:MouseEvent):void
		{
			_autoPlayClickFunc(_target);
			delEventFn(MouseEvent.CLICK, AUTOPLAY_ON);
			stop();
		}
		
		private function onStopHandler(e:MouseEvent):void
		{
			_stopAutoPlayClickFunc(_target);
			delEventFn(MouseEvent.CLICK, STOP_ON);
			start();
		}
	}

}