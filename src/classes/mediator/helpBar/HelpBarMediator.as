package classes.mediator.helpBar
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import classes.mediator.bottomBar.BtnHelpMediator;
	import classes.utli.UtliHtouchScroll;
	import classes.utli.UtliMouseClick;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class HelpBarMediator extends Mediator implements IMediator
	{
		private var _myHScroll:UtliHtouchScroll;
		static public const NAME:String = "HelpBarMediatorName";
		
		public function HelpBarMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
			_myHScroll = new UtliHtouchScroll(contView, maskView);
			
			_myHScroll.LEFT = preButton;
			_myHScroll.RIGHT = nextButton;
			_myHScroll.tween = 0.3; //缓动 0-1之间	1为不缓动 | 默认0.3
			_myHScroll.moveSetp = 800; //左右按钮移动幅度 | 默认200
			_myHScroll.autoMask = true; //是否自动遮罩
			
			helpBarView.visible = false;
			helpBarView.rotationX = -90;
			//UtliMouseClick.setup(nextButton, onMouseEventHandler);
			//UtliMouseClick.setup(preButton, onMouseEventHandler);
			UtliMouseClick.setup(backToGameButton, onMouseEventHandler);
			nextButton.gotoAndStop("normal");
			preButton.gotoAndStop("normal");
			hide();
		}
		
		private function onMouseEventHandler(value:MovieClip):void
		{
			switch (value.name)
			{
				case "__NextButton": 
					break;
				case "__PreButton": 
					break;
				case "__BackToGameButton": 
					hide();
					break;
			
			}
		
		}
		
		override public function handleNotification(notification:INotification):void
		{
			show();
		
		}
		
		private function hide():void
		{
			TweenLite.to(helpBarView, .6, {rotationX: -90, ease: Cubic.easeIn, onComplete: stopOver});
			function stopOver()
			{
				helpBarView.visible = false;
			}
		}
		
		private function show():void
		{
			helpBarView.visible = true;
			TweenLite.to(helpBarView, .6, {rotationX: 0, ease: Cubic.easeOut});
		}
		
		override public function listNotificationInterests():Array
		{
			return [BtnHelpMediator.SHOW_HELP];
		}
		
		private function get contView():MovieClip
		{
			return viewComponent.__Cont as MovieClip;
		}
		
		private function get maskView():MovieClip
		{
			return viewComponent.__Mask as MovieClip;
		}
		
		private function get nextButton():MovieClip
		{
			return viewComponent.__NextButton as MovieClip;
		}
		
		private function get preButton():MovieClip
		{
			return viewComponent.__PreButton as MovieClip;
		}
		
		private function get backToGameButton():MovieClip
		{
			return viewComponent.__BackToGameButton as MovieClip;
		}
		
		private function get helpBarView():Sprite
		{
			return viewComponent as Sprite;
		}
	
	}

}