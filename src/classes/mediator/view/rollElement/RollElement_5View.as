package classes.mediator.view.rollElement 
{
	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement5View")]
	public class RollElement_5View extends BaseRollElementView 
	{
		
		public function RollElement_5View() 
		{
			super();
			this._name = "Bar_2";
			this._elementId = "5";
		}
		override public function clone():BaseRollElementView 
		{
			return new RollElement_5View();
		}
		
	}

}