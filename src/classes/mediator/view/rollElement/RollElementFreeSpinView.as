package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="FSView")]
	public class RollElementFreeSpinView extends BaseRollElementView
	{

		public function RollElementFreeSpinView()
		{
			super();
			this._name="FreeSpin";
			this._elementId="7";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElementFreeSpinView();
		}

	}

}
