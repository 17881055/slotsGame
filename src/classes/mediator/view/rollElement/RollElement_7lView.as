package classes.mediator.view.rollElement
{

	/**
	 * ...
	 * @author Ethan
	 */
	[Embed(source="../../../../../assets/Spartania.swf", symbol="RollElement7View")]
	public class RollElement_7lView extends BaseRollElementView
	{

		public function RollElement_7lView()
		{
			super();
			this._name="Bell";
			this._elementId="3";
		}

		override public function clone():BaseRollElementView
		{
			return new RollElement_7lView();
		}

	}

}
