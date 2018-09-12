package classes.manage
{

	import classes.mediator.view.rollElement.BaseRollElementView;
	import classes.mediator.view.rollElement.RollElement_1View;
	import classes.mediator.view.rollElement.RollElement_2View;
	import classes.mediator.view.rollElement.RollElement_3View;
	import classes.mediator.view.rollElement.RollElement_4View;
	import classes.mediator.view.rollElement.RollElement_5View;
	import classes.mediator.view.rollElement.RollElement_6View;
	import classes.mediator.view.rollElement.RollElement_7lView;
	import classes.mediator.view.rollElement.RollElementFreeSpinView;
	import classes.mediator.view.rollElement.RollElement_8View;
	import classes.mediator.view.rollElement.RollElement_9View;
	import classes.mediator.view.rollElement.RollElement_10View;
	import classes.mediator.view.RollBarView;

	/**
	 * ...
	 * @author Ethan
	 */
	public class RollManageView
	{
		static public const ELEMENT_HEIGHT:uint=153;

		private var _rollBar_1View:RollBarView;
		private var _rollBar_2View:RollBarView;
		private var _rollBar_3View:RollBarView;
		private var _rollBar_4View:RollBarView;
		private var _rollBar_5View:RollBarView;

		public function RollManageView()
		{
			init();
		}

		private function init():void
		{
			registerBar_1();
			registerBar_2();
			registerBar_3();
			registerBar_4();
			registerBar_5();
		}

		private function registerBar_1():void
		{
			_rollBar_1View=new RollBarView();
			var _elements:Vector.<BaseRollElementView>;
			_elements=new <BaseRollElementView>[seven_1, plums, bar_2, wild, bell, bar_3, seven_2, lemon, bell, seven_3, bar_1, plums, lemon];
			var _name:String="rollBar_1";
			addElementChild(_elements, _rollBar_1View, _name);
		}

		private function registerBar_2():void
		{
			_rollBar_2View=new RollBarView();
			var _elements:Vector.<BaseRollElementView>;
			_elements=new <BaseRollElementView>[seven_2, bar_2, lemon, seven_3, bell, wild, seven_1, lemon, freeSpin, plums, freeSpin, bar_3, bar_1, plums, bell];
			var _name:String="rollBar_2";
			addElementChild(_elements, _rollBar_2View, _name);
		}

		private function registerBar_3():void
		{
			_rollBar_3View=new RollBarView();
			var _elements:Vector.<BaseRollElementView>;
			_elements=new <BaseRollElementView>[bar_2, bell, bar_1, plums, plums, seven_2, lemon, seven_1, bell, wild, freeSpin, bar_3, lemon, seven_3];
			var _name:String="rollBar_3";
			addElementChild(_elements, _rollBar_3View, _name);
		}

		private function registerBar_4():void
		{
			_rollBar_4View=new RollBarView();
			var _elements:Vector.<BaseRollElementView>;
			_elements=new <BaseRollElementView>[plums, bar_3, bell, wild, bar_1, plums, seven_3, lemon, bar_2, freeSpin, bell, seven_1, lemon, seven_2];
			var _name:String="rollBar_4";
			addElementChild(_elements, _rollBar_4View, _name);
		}

		private function registerBar_5():void
		{
			_rollBar_5View=new RollBarView();
			var _elements:Vector.<BaseRollElementView>;
			_elements=new <BaseRollElementView>[bar_3, plums, freeSpin, seven_1, seven_3, bell, lemon, plums, bar_1, seven_2, lemon, bar_2, bell, wild];
			var _name:String="rollBar_5";
			addElementChild(_elements, _rollBar_5View, _name);
		}

		private function addElementChild(elements:Vector.<BaseRollElementView>, target:RollBarView, targetName:String):void
		{
			target.elements=elements;
			target.name=targetName;
			target.mouseChildren=false;
			var _x:Number=0;
			var _y:Number=0;
			for each (var _element:BaseRollElementView in elements)
			{
				target.addChild(_element);
				trace(_element.name);
				_element.y=_y * ELEMENT_HEIGHT;
				_element.x=_x;
				_y+=1;
			}
		}

		public function get wild():BaseRollElementView
		{
			return new RollElement_10View();
		}

		public function get plums():BaseRollElementView
		{
			return new RollElement_9View();
		}

		public function get lemon():BaseRollElementView
		{
			return new RollElement_8View();
		}

		public function get freeSpin():BaseRollElementView
		{
			return new RollElementFreeSpinView();
		}

		public function get bell():BaseRollElementView
		{
			return new RollElement_7lView();
		}

		public function get bar_1():BaseRollElementView
		{
			return new RollElement_4View();
		}

		public function get bar_2():BaseRollElementView
		{
			return new RollElement_5View();
		}

		public function get bar_3():BaseRollElementView
		{
			return new RollElement_6View();
		}

		public function get seven_1():BaseRollElementView
		{
			return new RollElement_1View();
		}

		public function get seven_2():BaseRollElementView
		{
			return new RollElement_2View();
		}

		public function get seven_3():BaseRollElementView
		{
			return new RollElement_3View();
		}

		public function get rollBar_1View():RollBarView
		{
			return _rollBar_1View;
		}

		public function get rollBar_2View():RollBarView
		{
			return _rollBar_2View;
		}

		public function get rollBar_3View():RollBarView
		{
			return _rollBar_3View;
		}

		public function get rollBar_4View():RollBarView
		{
			return _rollBar_4View;
		}

		public function get rollBar_5View():RollBarView
		{
			return _rollBar_5View;
		}

	}

}

