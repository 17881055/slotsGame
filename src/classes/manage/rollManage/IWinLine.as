package classes.manage.rollManage
{
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Ethan
	 */
	public interface IWinLine
	{
		function showWinLine():void;
		function hideWinLine():void;
		function showFreeGame():void;
		function hideFreeGame():void;
		function setWinLineData(winLines:Vector.<String>):void;
		// 新增

		/**
		 * 获取索引号的线并显示
		 * @param value
		 *
		 */
		function getLinerAndShow(value:uint):void
		/**
		 * 隐藏线
		 */
		function clearLiner():void

	}
}
