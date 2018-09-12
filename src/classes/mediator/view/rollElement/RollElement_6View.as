package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement6View")]
	public class RollElement_6View extends BaseRollElementView
	{

		public function RollElement_6View()
		{
			super();
			this._name="Bar_3";
			this._elementId="6";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_6View();
		}

	}

}
