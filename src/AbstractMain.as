package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;


	public class AbstractMain extends Sprite
	{
		static public var GAME_NAME:String;
		static public var GAME_ID:String;
		static public var LINE_COLOR:Array=new Array();
		static public var BG_COLOR:uint=0xFFFFFF;
		static public var SPEED:uint=40;
		static public var ALPHA_BG:Boolean=false;
		static public var ROLL_Y:Number;
		static public var ROLL_1X:Number;
		static public var ROLL_2X:Number;
		static public var ROLL_3X:Number;
		static public var ROLL_4X:Number;
		static public var ROLL_5X:Number;
		/**
		 *  Jackpot
		 */
		public var winJackpot:DisplayObject;
		/**
		 * freeGameBar背景转换
		 */
		public var freeGameBar:DisplayObject;
		/**
		 * 头部容器 包括分，JACKPOT 等
		 */
		public var topBar:DisplayObject;
		/**
		 * 下部容器包括按钮等
		 */
		public var bottomBar:DisplayObject;
		/**
		 * 线容器
		 */
		public var lineBtnBar:DisplayObject;
		/**
		 * 滚动容器
		 */
		public var rollBar:DisplayObject;
		/**
		 * 帮助容器
		 */
		public var helpBar:DisplayObject;

		public function AbstractMain()
		{
			setupChildView();
		}

		/**
		 *设置SWF 中每个子 容器 对应的属性
		 *
		 */
		protected function setupChildView():void
		{
		}


	}
}
