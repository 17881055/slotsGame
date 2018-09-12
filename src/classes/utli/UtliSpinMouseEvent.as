package classes.utli
{
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliSpinMouseEvent
	{
		private const SPIN_ON:String = "spin_on"; // 可点击滚动;有点击事件
		//1.4.0
		private const KEY_SPIN_ON:String = "key_spin_on";
		private const SPIN_OFF:String = "spin_off"; //默认状态//Autoplay;不能点击时使用; balance不够;freeGame;去除点击事件;
		private const STOP_ON:String = "stop_on"; // 可点击停止滚动;有点击事件
		//1.4.0
		private const KEY_STOP_ON:String = "key_stop_on";
		private const STOP_OFF:String = "stop_off"; // 点击完停止滚动后使用;去点击除事件
		private var _spinOnClickFunc:Function;
		private var _stopOnClickFunc:Function;
		private var _target:MovieClip;
		private var _dic:Dictionary;
		
		public function UtliSpinMouseEvent(value:MovieClip, startClickFunc:Function, stopClickFunc:Function)
		{
			
			_spinOnClickFunc = startClickFunc;
			_stopOnClickFunc = stopClickFunc;
			_target = value;
			init();
		
		}
		
		private function init():void
		{
			_dic = new Dictionary(true);
			unable();
		}
		
		//注册事件
		//1.4.0
		private function addEventFn(type:String, func:Function, name:String):void
		{
			_dic[name] = func;
			if (type == KeyboardEvent.KEY_DOWN)
			{
				_target.stage.addEventListener(type, func);
			}
			else
			{
				_target.addEventListener(type, func);
			}
		
		}
		
		//删除事件
		//1.4.0
		private function delEventFn(type:String, name:String):void
		{
			if (type == KeyboardEvent.KEY_DOWN)
			{
				_target.stage.removeEventListener(type, _dic[name]);
			}
			else
			{
				_target.removeEventListener(type, _dic[name]);
			}
		
		}
		
		//删除所有事件
		//1.4.0
		private function delAllEvent(type:String):void
		{
			if (type == KeyboardEvent.KEY_DOWN)
			{
				for each (var _f:Function in _dic)
				{
					_target.stage.removeEventListener(type, _f);
				}
			}
			else
			{
				for each (var _ff:Function in _dic)
				{
					_target.removeEventListener(type, _ff);
				}
			}
		}
		
		// SPIN_ON
		//1.4.0
		public function start():void
		{
			
			if (_target.currentFrameLabel != SPIN_ON)
			{
				_target.buttonMode = true;
				addEventFn(MouseEvent.CLICK, onStartHandler, SPIN_ON);
				addEventFn(KeyboardEvent.KEY_DOWN, onKeyDownPlayHandler, KEY_SPIN_ON);
				_target.gotoAndStop(SPIN_ON);
			}
		}
		
		//1.4.0
		public function unable():void
		{
			
			_target.buttonMode = false;
			_target.gotoAndStop(SPIN_OFF);
			delAllEvent(MouseEvent.CLICK);
			delAllEvent(KeyboardEvent.KEY_DOWN);
		}
		
		//STOP_ON
		//1.4.0
		private function stop():void
		{
			addEventFn(MouseEvent.CLICK, onStopHandler, STOP_ON);
			addEventFn(KeyboardEvent.KEY_DOWN, onKeyDownStopHandler, KEY_STOP_ON);
			_target.gotoAndStop(STOP_ON);
		}
		
		//STOP_OFF
		private function stopOff():void
		{
			_target.buttonMode = false;
			_target.gotoAndStop(STOP_OFF);
		}
		
		//1.4.0 点击开始
		private function onKeyDownPlayHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				alterStart();
			}
		}
		
		//1.4.0  点击开始
		private function onStartHandler(e:MouseEvent):void
		{
			alterStart();
		}
		
		//1.4.0 点击停止
		private function onKeyDownStopHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				alterStop();
			}
		}
		
		//1.4.0 点击停止
		private function onStopHandler(e:MouseEvent):void
		{
			alterStop();
		}
		
		//1.4.0 点击开始之後執行
		private function alterStart():void
		{
			_spinOnClickFunc(_target);
			delEventFn(MouseEvent.CLICK, SPIN_ON);
			delEventFn(KeyboardEvent.KEY_DOWN, KEY_SPIN_ON);
			stop();
		}
		
		//1.4.0 点击停止之後執行
		private function alterStop():void
		{
			_stopOnClickFunc(_target);
			delEventFn(MouseEvent.CLICK, STOP_ON);
			delEventFn(KeyboardEvent.KEY_DOWN, KEY_STOP_ON);
			stopOff();
		}
	}

}