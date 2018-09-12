package classes.manage.rollManage 
{
	import classes.mediator.view.rollElement.BaseRollElementView;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public interface IStopRoll 
	{
		function autoStop():void;
		function manuallyStop():void;
		function getRollElementView(rows:uint,column:uint):BaseRollElementView;
		function setStopData(value_1:int,value_2:int,value_3:int,value_4:int,value_5:int):void;
		function darken():void
	}
	
}