package classes.utli
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliClearChild
	{
		
		public function UtliClearChild()
		{
		
		}
		
		static public function clearChildren(parent:DisplayObjectContainer):void
		{
			for (var i:uint = parent.numChildren; i > 0; i--)
			{
				parent.removeChildAt(0);
			}
		
		}
	
	}
}