package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement9View")]
	public class RollElement_9View extends BaseRollElementView
	{

		public function RollElement_9View()
		{
			super();
			this._name="Plums";
			this._elementId="1";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_9View();
		}
	}

}
