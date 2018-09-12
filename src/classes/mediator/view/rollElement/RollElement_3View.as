package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement3View")]
	public class RollElement_3View extends BaseRollElementView
	{

		public function RollElement_3View()
		{
			super();
			this._name="7_3";
			this._elementId="10";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_3View();
		}

	}

}
