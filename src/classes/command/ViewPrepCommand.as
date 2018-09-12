package classes.command
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import classes.mediator.bottomBar.BetBarMediator;
	import classes.mediator.bottomBar.BtnBackMediator;
	import classes.mediator.bottomBar.BtnHelpMediator;
	import classes.mediator.bottomBar.BtnPlayMediator;
	import classes.mediator.bottomBar.LinesBarMediator;
	import classes.mediator.bottomBar.displayView.DisplayBackgroundMediator;
	import classes.mediator.bottomBar.displayView.DisplayBalanceMediator;
	import classes.mediator.bottomBar.displayView.DisplayBetMediator;
	import classes.mediator.bottomBar.displayView.DisplayFreeGameMediator;
	import classes.mediator.bottomBar.displayView.DisplayWinMediator;
	import classes.mediator.helpBar.HelpBarMediator;
	import classes.mediator.middleBar.LineBtnBarMediator;
	import classes.mediator.middleBar.RollBarMediator;
	import classes.mediator.middleBar.WinJackpotMediator;
	import classes.mediator.topBar.TopBarMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author ethan
	 */
	public class ViewPrepCommand extends SimpleCommand
	{
		
		public function ViewPrepCommand()
		{
		
		}
		
		override public function execute(notification:INotification):void
		{
			var _main:AbstractMain;
			if(notification.getBody() is Spartania) {
				_main = notification.getBody() as Spartania;
				}
			
			_main.stage.frameRate = 60;
			_main.stage.showDefaultContextMenu = false;
			//jackpot fire
			var _winJackpot:MovieClip = _main.winJackpot as MovieClip;
			facade.registerMediator(new WinJackpotMediator(WinJackpotMediator.NAME, _winJackpot));
			//freegame Bg
			var _fBg:Sprite = _main.freeGameBar as Sprite;
			facade.registerMediator(new DisplayBackgroundMediator(DisplayBackgroundMediator.NAME, _fBg));
			//topBar
			var _topBar:Sprite = _main.topBar as Sprite;
			facade.registerMediator(new TopBarMediator(TopBarMediator.NAME, _topBar));
			//bottomBar
			var _bottomBar:Sprite = _main.bottomBar as Sprite;
			var _btnPlay:MovieClip = _bottomBar.getChildByName("__PlayBtn") as MovieClip;
			facade.registerMediator(new BtnPlayMediator(BtnPlayMediator.NAME, _btnPlay));
			var _balanceDisplay:MovieClip = _bottomBar.getChildByName("__BalanceDisplay")  as MovieClip;
			facade.registerMediator(new DisplayBalanceMediator(DisplayBalanceMediator.NAME, _balanceDisplay));
			var _betDisplay:MovieClip =  _bottomBar.getChildByName("__BetDisplay") as MovieClip;
			facade.registerMediator(new DisplayBetMediator(DisplayBetMediator.NAME, _betDisplay));
			var _winDisplay:MovieClip =  _bottomBar.getChildByName("__WinDisplay") as MovieClip ;
			facade.registerMediator(new DisplayWinMediator(DisplayWinMediator.NAME, _winDisplay));
			var _btnBack:MovieClip =  _bottomBar.getChildByName("__BtnBack") as MovieClip;
			facade.registerMediator(new BtnBackMediator(BtnBackMediator.NAME, _btnBack));
			var _btnHelp:MovieClip =  _bottomBar.getChildByName("__BtnHelp") as MovieClip;
			facade.registerMediator(new BtnHelpMediator(BtnHelpMediator.NAME, _btnHelp));
			var _betBar:MovieClip =  _bottomBar.getChildByName("__BetBar") as MovieClip;
			facade.registerMediator(new BetBarMediator(BetBarMediator.NAME, _betBar));
			var _linesBar:MovieClip =  _bottomBar.getChildByName("__linesBar") as MovieClip;
			facade.registerMediator(new LinesBarMediator(LinesBarMediator.NAME, _linesBar));
			var _freegameDisplay:MovieClip =  _bottomBar.getChildByName("__FreeGameDisplay") as MovieClip ;
			facade.registerMediator(new DisplayFreeGameMediator(DisplayFreeGameMediator.NAME, _freegameDisplay));
			
			//lineBtnBar
			var _lineBtnBar:Sprite = _main.lineBtnBar as Sprite;
			facade.registerMediator(new LineBtnBarMediator(LineBtnBarMediator.NAME, _lineBtnBar));
			
			//rollBar
			var _rollBar:Sprite = _main.rollBar as Sprite;
			facade.registerMediator(new RollBarMediator(RollBarMediator.NAME, _rollBar));
			
			//修改4
			//helpBar
			var _helpBar:Sprite = _main.helpBar as Sprite;
			facade.registerMediator(new HelpBarMediator(HelpBarMediator.NAME, _helpBar));
		
		}
	}

}