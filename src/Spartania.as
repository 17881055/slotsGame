package
{

	import flash.events.Event;

	import AbstractMain;


	/**
	 * ...
	 * @author Ethan
	 */
	[SWF(width="1024", height="768", backgroundColor="#000000", frameRate="40")]
	public class Spartania extends AbstractMain
	{


		public function Spartania()
		{
			GAME_NAME="Spartania";
			GAME_ID="23";
			//测试ID
			//GAME_ID = "2";
			SPEED=40;
			BG_COLOR=0xffffff;
			ALPHA_BG=true;
			//滚动栏Y轴
			ROLL_Y=29;
			//栏1——X轴
			ROLL_1X=91;
			//栏2——X轴
			ROLL_2X=246;
			//栏3——X轴
			ROLL_3X=402;
			//栏4——X轴
			ROLL_4X=556;
			//栏5——X轴
			ROLL_5X=709;
			LINE_COLOR=[0xD00204,
						0xFF3437,
						0xFF655C,
						0x05FB00,
						0x39FF38,
						0x5DFF68,
						0x92FF91,
						0xFF00FF,
						0xFF49FF,
						0x5058D7,
						0xFFFD40,
						0x0801CB,
						0x66FC67,
						0xFE3034,
						0xF35A5C,
						0x0ADF09,
						0x625CBE,
						0xFA0C09,
						0x82FA99,
						0x0003EB,
						0xFF4DFF,
						0x31FA3C,
						0xF9F74C,
						0xFF03FC];
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);

		}

		override protected function setupChildView():void
		{
			winJackpot=new WinJackpot;
			topBar=new TopBar;
			bottomBar=new BottomBar;
			lineBtnBar=new LineBtnBar;
			rollBar=new RollBar;
			helpBar=new HelpBar;
			freeGameBar=new FreeGameBar;
			addView();
		}

		protected function addView():void
		{
			this.addChild(freeGameBar);
			this.addChild(bottomBar);
			this.addChild(rollBar);
			rollBar.x=42;
			rollBar.y=102;
			this.addChild(topBar);
			this.addChild(winJackpot);
			bottomBar.y=596;
			this.addChild(lineBtnBar);
			lineBtnBar.x=100;
			lineBtnBar.y=100;
			this.addChild(helpBar);
			helpBar.visible=false;

		}

		public function init(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			ApplicationFacade.getInstance().startup(this);

		}

	}

}
