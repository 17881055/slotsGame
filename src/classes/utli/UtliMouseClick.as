package classes.utli
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliMouseClick
	{
		private var _target:MovieClip;
		private var _onClickFunc:Function;
		
		public function UtliMouseClick(value:MovieClip, onClickFunc:Function)
		{
			_target = value;
			_onClickFunc = onClickFunc;
			init();
		}
		
		private function init():void
		{
			_target.buttonMode = true;
			_target.addEventListener(MouseEvent.CLICK, onMouseClickHandler);
		}
		
		private function onMouseClickHandler(e:MouseEvent):void
		{
			_onClickFunc(_target);
		}
		
		static public function setup(value:MovieClip, onClickFunc:Function):void
		{
			new UtliMouseClick(value, onClickFunc);
		}
	
	}

}