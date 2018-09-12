/*
  横板拖动菜单 (适用于触屏)
*/

package classes.utli{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class UtliHtouchScroll{
		
		public var tween:Number = 0.3;		//缓动 0-1之间	1为不缓动
		public var moveSetp:Number = 200;	//左右按钮移动幅度
	
		private var v_targetMC:MovieClip;
		private var v_maskMC:MovieClip;
		private var v_Lbnt:MovieClip;
		private var v_Rbnt:MovieClip;
		
		private var automask:Boolean = false;//是否自动遮罩
		private var LimitLeft:Number;
		private var LimitRight:Number;
		private var toPositionX:Number;
		private var StartPositionX:Number;
		private var distance:Number;
		private var StopPos:Number;


		
		/**
		 * 横板拖动菜单
		 * @param	ScrollMc	//被遮罩对象
		 * @param	MaskMC		//遮罩
		 */
		public function UtliHtouchScroll(ScrollMC:MovieClip, MaskMC:MovieClip) {
			
			v_targetMC = ScrollMC ;
			v_maskMC = MaskMC ;
			
			StopPos = v_targetMC.x;			//原始点
			v_maskMC.x = v_targetMC.x;
			v_maskMC.y = v_targetMC.y;
			distance = StopPos;				//让mc出现时在原始点
			
			LimitLeft = v_maskMC.x;											//左边界
			LimitRight = v_maskMC.x - v_targetMC.width + v_maskMC.width;	//右边界
			
			
			
			addEventListeners();
		}
		
		private function addEventListeners() {
			v_targetMC.addEventListener(MouseEvent.MOUSE_DOWN,MouseDown);	
			v_targetMC.addEventListener(MouseEvent.MOUSE_UP,MouseUp);
			v_targetMC.addEventListener(MouseEvent.CLICK,MouseUp);
			v_targetMC.addEventListener(MouseEvent.ROLL_OUT, MouseUp);
			v_targetMC.stage.addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	
		public function set autoMask(e:Boolean) {
			automask = e;
			if (automask){
				v_targetMC.mask = v_maskMC;			//遮罩
			}
		}
		
		//加载左按钮
		public function set LEFT(mc:MovieClip) {
			v_Lbnt = mc;
			v_Lbnt.addEventListener(MouseEvent.CLICK, Lbnt_Click);
		}
		
		//加载右按钮
		public function set RIGHT(mc:MovieClip) {
			v_Rbnt = mc;
			v_Rbnt.addEventListener(MouseEvent.CLICK, Rbnt_Click);
		}
		
	
		//刷新滚动条
		public function reFresh() {
			distance = StopPos;												//mc移动回原点
			LimitRight = v_maskMC.x - v_targetMC.width + v_maskMC.width;	//右边界
			
		}
			
		private function Lbnt_Click(e:MouseEvent) {
			distance += moveSetp;
		}
		private function Rbnt_Click(e:MouseEvent) {
			distance -= moveSetp;
		}
		
		//鼠标点击
		private function MouseDown(e:MouseEvent) {
			v_targetMC.addEventListener(Event.ENTER_FRAME,onEnterFrames);
			StartPositionX = v_targetMC.stage.mouseX - v_targetMC.x;				//起始位置
			
		}
		
		//鼠标释放点击
		private function MouseUp(e:MouseEvent) {
			v_targetMC.removeEventListener(Event.ENTER_FRAME,onEnterFrames);
		}
		
		//鼠标点击时
		private function onEnterFrames(e:Event) {
			toPositionX=v_targetMC.stage.mouseX;
			distance = toPositionX - StartPositionX;
		}
		
		
		//持续执行
		private function EnterFrame(e:Event) {
			if (distance<=LimitRight ) {
				distance = LimitRight;
				v_Rbnt.gotoAndStop("over");
				v_Rbnt.enabled = false;			//针对MC
				v_Rbnt.mouseChildren = false;	//针对MC中包含Button
				v_Rbnt.buttonMode = false;
			} else if (distance>=LimitLeft) {
				distance = LimitLeft;
				v_Lbnt.gotoAndStop("over");
				v_Lbnt.enabled = false;			//针对MC
				v_Lbnt.mouseChildren = false;	//针对MC中包含Button
				v_Lbnt.buttonMode = false;
			}
			else {
				v_Lbnt.gotoAndStop("normal");
				v_Rbnt.gotoAndStop("normal");
				v_Lbnt.enabled = v_Rbnt.enabled = true;
				v_Lbnt.mouseChildren = v_Rbnt.mouseChildren = true;
				v_Lbnt.buttonMode = v_Rbnt.buttonMode = true;
			}
			
			

			v_targetMC.x += (distance-v_targetMC.x) * tween;		//核心语句
			
		}



	}

}