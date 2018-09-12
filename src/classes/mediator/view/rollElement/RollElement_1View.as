package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement1View")]
	public class RollElement_1View extends BaseRollElementView
	{

		public function RollElement_1View()
		{
			super();
			this._name="7_1";
			this._elementId="8";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_1View();
		}

	}

}
