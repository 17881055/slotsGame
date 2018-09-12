package classes.utli
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliMouseEvent
	{
		private var _target:MovieClip;
		private var _onClickFunc:Function;
		private var _isClick:Boolean;
		
		public function UtliMouseEvent(value:MovieClip, onClickFunc:Function)
		{
			_isClick = true;
			_target = value;
			_onClickFunc = onClickFunc;
			init();
		}
		
		private function init():void
		{
			ableClick();
		}
		
		private function onMouseClickHandler(e:MouseEvent):void
		{
			if (_isClick) {
				_onClickFunc(_target);
			}
		}
		
		//不能点击
		public function stopClick():void
		{
			_target.mouseEnabled = false;
			_target.gotoAndStop("off");
			_target.removeEventListener(MouseEvent.CLICK, onMouseClickHandler);
			
		}
		
		// 恢复点击
		public function ableClick():void
		{
			if (!_target.hasEventListener(MouseEvent.CLICK) && _isClick)
			{
				_target.gotoAndStop("on");
				_target.addEventListener(MouseEvent.CLICK, onMouseClickHandler);
				_target.mouseEnabled = true;
			}
		}
		
		static public function setup(value:MovieClip, onClickFunc:Function):UtliMouseEvent
		{
			return new UtliMouseEvent(value, onClickFunc);
		}
		
		public function set isClick(value:Boolean):void 
		{
			_isClick = value;
		}
		
		public function get isClick():Boolean 
		{
			return _isClick;
		}
		
		
		
	}

}