package classes.mediator.view
{
	/**
	 * ...
	 * @author Ethan
	 */
	import classes.mediator.view.rollElement.BaseRollElementView;
	import flash.display.MovieClip;
	
	public class RollBarView extends MovieClip
	{
		private var _elements:Vector.<BaseRollElementView>;
		
		public function RollManageView()
		{
		}
		
		public function getElement(value:int):BaseRollElementView
		{
			var _pi:uint;
			if (value < 0)
			{
				_pi = _elements.length + value;
			}
			else if (value >= _elements.length)
			{
				_pi = value  - _elements.length ;
			}
			else
			{
				_pi = value;
			}
			return _elements[_pi].clone();
		}
		
		public function get elements():Vector.<BaseRollElementView>
		{
			return _elements;
		}
		
		public function set elements(value:Vector.<BaseRollElementView>):void
		{
			_elements = value;
		}
	}

}