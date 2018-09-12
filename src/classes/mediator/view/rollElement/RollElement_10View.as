package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement10View")]
	public class RollElement_10View extends BaseRollElementView
	{

		public function RollElement_10View()
		{
			super();
			this._name="Wild";
			this._elementId="0";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_10View();
		}
	}

}
