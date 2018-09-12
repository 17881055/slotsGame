package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement4View")]
	public class RollElement_4View extends BaseRollElementView
	{

		public function RollElement_4View()
		{
			super();
			this._name="Bar_1";
			this._elementId="4";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_4View();
		}

	}

}
