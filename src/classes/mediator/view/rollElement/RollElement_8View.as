package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement8View")]
	public class RollElement_8View extends BaseRollElementView
	{

		public function RollElement_8View()
		{
			super();
			this._name="Lemon";
			this._elementId="2";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_8View();
		}
	}

}
