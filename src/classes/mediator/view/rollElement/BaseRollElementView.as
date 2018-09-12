package classes.mediator.view.rollElement
{
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Ethan
	 */
	public class BaseRollElementView extends MovieClip
	{
		protected var _elementId:String;
		protected var _name:String;
		public var oldY:Number;
		private static const GO:String="go";
		private static const STOP:String="normal";

		public function BaseRollElementView()
		{
			addFrameScript(0, function() {stop();});
		}

		public function victorState():void
		{
			this.gotoAndPlay(GO);
		}

		public function normalState():void
		{
			this.gotoAndStop(STOP);
		}

		public function clone():BaseRollElementView
		{
			return new BaseRollElementView();
		}

		public function get elementId():String
		{
			return _elementId;
		}

		override public function get name():String
		{
			return _name;
		}
	}

}
