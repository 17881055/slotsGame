package classes.utli
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliMouseEventSpecial
	{

		private var _target:MovieClip;
		private var _onMouseEvnetFunc:Function;

		public function UtliMouseEventSpecial(value:MovieClip, onMouseEventFunc:Function)
		{
			_target=value;
			_onMouseEvnetFunc=onMouseEventFunc;
			init();
		}

		private function init():void
		{
			ableClick();
		}

		private function onMouseHandler(e:MouseEvent):void
		{
			_onMouseEvnetFunc(_target, e);
		}

		protected function onMouseOverHandler(e:MouseEvent):void
		{
			_onMouseEvnetFunc(_target, e);
		}

		protected function onMouseOutHandler(e:MouseEvent):void
		{
			_onMouseEvnetFunc(_target, e);
		}

		//取消选择
		public function unselect():void
		{
			_target.gotoAndStop("off");
		}

		// 选择
		public function select():void
		{
			_target.gotoAndStop("on");
		}

		/**
		 * 不能点击
		 */
		public function stopClick():void
		{

			_target.buttonMode=false;
			_target.removeEventListener(MouseEvent.CLICK, onMouseHandler);
			_target.removeEventListener(MouseEvent.MOUSE_OVER, onMouseHandler);
			_target.removeEventListener(MouseEvent.MOUSE_OUT, onMouseHandler);
		}



		// 恢复点击
		public function ableClick():void
		{
			_target.buttonMode=true;
			_target.addEventListener(MouseEvent.CLICK, onMouseHandler);
			_target.addEventListener(MouseEvent.MOUSE_OVER, onMouseHandler);
			_target.addEventListener(MouseEvent.MOUSE_OUT, onMouseHandler);
		}

		static public function setup(value:MovieClip, onClickFunc:Function):UtliMouseEvent
		{
			return new UtliMouseEvent(value, onClickFunc);
		}

	}

}
