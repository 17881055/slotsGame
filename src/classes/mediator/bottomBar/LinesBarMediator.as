package classes.mediator.bottomBar
{
	import classes.command.RollControlCommand;
	import classes.mediator.middleBar.LineBtnBarMediator;
	import classes.proxy.FreeGameProxy;
	import classes.proxy.vo.BetVo;
	import classes.proxy.vo.FreeGameVo;
	import classes.utli.UtliMouseEvent;
	import classes.utli.UtliSoundManage;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class LinesBarMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LinesBarMediator";
		public static const GIVE_LINE_DATA:String = "give_line_data";
		private var _lineAddBtn:UtliMouseEvent;
		private var _lineSubBtn:UtliMouseEvent;
		private var _lineNum:uint;
		private var _currentLineSelected:uint;
		private static var MaxLineNum:uint = 50;
		private static var MinLineNum:uint = 1;
		
		public function LinesBarMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
			_lineAddBtn = new UtliMouseEvent(linAddBtn, onMouseClickHandler);
			_lineSubBtn = new UtliMouseEvent(lineSubtractBtn, onMouseClickHandler);
			currentLineSelected = _lineNum = MaxLineNum;
			stopMouseEvent();
			
		}
		
		private function onMouseClickHandler(target:MovieClip):void
		{
			var _us:UtliSoundManage = UtliSoundManage.getInstance();
			switch (target.name)
			{
				case "__BtnLineAdd": 
					_lineNum++;
					//sound
					_us.addSound.play();
					break;
				case "__BtnLineSubtract": 
					_lineNum--;
					//sound
					_us.subSound.play();
					break;
			}
			currentLineSelected = _lineNum;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case LineBtnBarMediator.GIVE_LINE_DATA: 
					var _bv:BetVo = notification.getBody() as BetVo;
					currentLineSelected = _lineNum = _bv.lineNum;
					break;
				case RollControlCommand.CLOSE_LINE_OPERATE_COMMAND: 
					stopMouseEvent();
					break;
				case RollControlCommand.OPEN_LINE_COMMAND: 
					startMouseEvent();
					break;
				case FreeGameProxy.GIVE_FREEGAME_DATA:
					var _freeGame:FreeGameProxy = facade.retrieveProxy(FreeGameProxy.NAME) as FreeGameProxy;
					var _fg:FreeGameVo = _freeGame.getData() as FreeGameVo;
					currentLineSelected = _lineNum = _fg.lineNum;
					stopMouseEvent();
					break;
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [LineBtnBarMediator.GIVE_LINE_DATA, RollControlCommand.CLOSE_LINE_OPERATE_COMMAND, RollControlCommand.OPEN_LINE_COMMAND,FreeGameProxy.GIVE_FREEGAME_DATA];
		}
		
		private function startMouseEvent():void
		{
			if (_lineAddBtn.isClick)
				_lineAddBtn.ableClick();
			if (_lineSubBtn.isClick)
				_lineSubBtn.ableClick();
		
		}
		
		private function stopMouseEvent():void
		{
			_lineAddBtn.stopClick();
			_lineSubBtn.stopClick();
		}
		
		private function set currentLineSelected(value:uint):void
		{
			_currentLineSelected = value;
			if (_currentLineSelected == MaxLineNum)
			{
				_lineAddBtn.isClick = false;
				_lineAddBtn.stopClick();
			}
			else
			{
				_lineAddBtn.isClick = true;
				_lineAddBtn.ableClick();
			}
			if (_currentLineSelected == MinLineNum)
			{
				_lineSubBtn.isClick = false;
				_lineSubBtn.stopClick();
			}
			else
			{
				_lineSubBtn.isClick = true;
				_lineSubBtn.ableClick();
			}
			lineSmallDisplay.text = value + ' Lines Selected';
			lineBigDisplay.text = value.toString();
			//send Updata
			var _bv:BetVo = new BetVo();
			_bv.lineNum = value;
			sendNotification(GIVE_LINE_DATA, _bv);
		}
		
		private function get lineSmallDisplay():TextField
		{
			return viewComponent.__Line_s as TextField;
		}
		
		private function get lineBigDisplay():TextField
		{
			return viewComponent.__Line_b as TextField;
		}
		
		private function get linAddBtn():MovieClip
		{
			return viewComponent.__BtnLineAdd as MovieClip;
		}
		
		private function get lineSubtractBtn():MovieClip
		{
			return viewComponent.__BtnLineSubtract as MovieClip;
		}
		
		private function get linesBarView():MovieClip
		{
			return viewComponent as MovieClip;
		}
	
	}

}