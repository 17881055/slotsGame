package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement2View")]
	public class RollElement_2View extends BaseRollElementView
	{

		public function RollElement_2View()
		{
			super();
			this._name="7_2";
			this._elementId="9";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_2View();
		}

	}

}
