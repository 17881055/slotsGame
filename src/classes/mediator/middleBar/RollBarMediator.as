package classes.mediator.middleBar
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	import classes.command.RollControlCommand;
	import classes.mediator.bottomBar.displayView.DisplayBackgroundMediator;
	import classes.mediator.bottomBar.displayView.DisplayBalanceMediator;
	import classes.manage.rollManage.IRoll;
	import classes.manage.rollManage.IStopRoll;
	import classes.manage.rollManage.IWinLine;
	import classes.manage.rollManage.RollStartManage;
	import classes.manage.rollManage.RollStopManage;
	import classes.manage.rollManage.RollStopWithAlphaBgManage;
	import classes.manage.rollManage.WinLineManage;
	import classes.mediator.view.RollBarView;
	import classes.proxy.BetProxy;
	import classes.proxy.FreeGameProxy;
	import classes.proxy.PlayStateProxy;
	import classes.proxy.ResultProxy;
	import classes.proxy.RollStateProxy;
	import classes.proxy.SaveFreeGameProxy;
	import classes.proxy.SetResultProxy;
	import classes.proxy.vo.BetVo;
	import classes.proxy.vo.FreeGameVo;
	import classes.proxy.vo.PlayStateVo;
	import classes.proxy.vo.ResultVo;
	import classes.proxy.vo.RollVo;
	import classes.proxy.vo.WinVo;
	import classes.proxy.vo.lineVo;
	import classes.utli.UtliSoundManage;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * ...
	 * @author Ethan
	 */
	public class RollBarMediator extends Mediator implements IMediator
	{

		static public const NAME:String="RollBarMediator";
		static public const NORMAL_STOP_ROLL_EVENT:String="NormalstopRollEvent";
		static public const STOP_MANUALLY_STOP_ROLL_COMMAND:String="stop_manually_stop_roll_command";
		static public const ROLL_OVER_EVENT:String="rollOverEvent";
		static public const REQUEST_BALANCE_DATA_COMMAND:String="requestBalanceDataCommand";
		static public const UPDATA_DISPLAY_WIN_COMMAND:String="updataDisplayWinCommand";
		static public const UPDATA_DISPLAY_BACKGROUND_COMMAND:String="updataDisplayBackgroundCommand";
		static public const UPDATA_DISPLAY_FREEGAME_COMMAND:String="updataDisplayFreegameCommand"; // 更新FreeGame 显示
		static public const MANUALLY_TIME:Number=2;
		static public const AUTOPLAY_TIME:Number=2;
		//滚动开始处理
		static public const ROLLING_START_PROCESSING:String="rolling_start_processing";
		//滚动控制实例
		private var _rollStartManage:IRoll;
		//滚动停止控制实例
		private var _rollStopManage:IStopRoll;
		/**
		 * 中奖线显示控制管理器
		 */
		private var _winLineManage:IWinLine;
		//声音控制类
		private var _sound:UtliSoundManage;
		//游戏状态
		private var _state:String;
		//是否Autoplay
		private var _isAutoPlay:Boolean;
		private var _manuallytimer:Timer;
		private var _autoPlaytimer:Timer;
		private var _resultVo:ResultVo;
		private var _playStateVo:PlayStateVo;
		private var _randomId:uint;
		//freegame 次数
		private var _freegameNum:uint;
		private var _freegameSoundNum:uint;
		private var _fristTimeinFreeGame:Boolean;
		private var _soundChannel:SoundChannel
		private var isRoll:Boolean;
		private var isManuallyStop:Boolean;

		public function RollBarMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			init();
		}

		private function init():void
		{


			//滚动条位置
			rollBarView.__mask1.x=rollCont_1View.x=AbstractMain.ROLL_1X;
			rollBarView.__mask1.y=rollCont_1View.y=AbstractMain.ROLL_Y;
			rollBarView.__mask2.x=rollCont_2View.x=AbstractMain.ROLL_2X;
			rollBarView.__mask2.y=rollCont_2View.y=AbstractMain.ROLL_Y;
			rollBarView.__mask3.x=rollCont_3View.x=AbstractMain.ROLL_3X;
			rollBarView.__mask3.y=rollCont_3View.y=AbstractMain.ROLL_Y;
			rollBarView.__mask4.x=rollCont_4View.x=AbstractMain.ROLL_4X;
			rollBarView.__mask4.y=rollCont_4View.y=AbstractMain.ROLL_Y;
			rollBarView.__mask5.x=rollCont_5View.x=AbstractMain.ROLL_5X;
			rollBarView.__mask5.y=rollCont_5View.y=AbstractMain.ROLL_Y;

			_fristTimeinFreeGame=true; //控制进入 FREEGAME 声音
			_freegameNum=0;
			_randomId=int(Math.random() * 1000);
			_manuallytimer=new Timer(1000, MANUALLY_TIME);
			_manuallytimer.addEventListener(TimerEvent.TIMER_COMPLETE, overTimeManuallyStopRollHandler);
			_autoPlaytimer=new Timer(1000, AUTOPLAY_TIME);
			_autoPlaytimer.addEventListener(TimerEvent.TIMER_COMPLETE, overTimeAutoPlayStopRollHandler);
			_sound=UtliSoundManage.getInstance();
			_sound.welcomeSound.play();
			_soundChannel=new SoundChannel();

			_rollStartManage=new RollStartManage(rollBarView, rollCont_1View, rollCont_2View, rollCont_3View, rollCont_4View, rollCont_5View);

			if (AbstractMain.ALPHA_BG)
			{
				_rollStopManage=new RollStopWithAlphaBgManage(rollStopContView, _rollStartManage, stopRoll,
															  mask_1,
															  mask_2,
															  mask_3,
															  mask_4,
															  mask_5);

			}
			else
			{

				_rollStopManage=new RollStopManage(rollStopContView, _rollStartManage, stopRoll);
			}

			_winLineManage=new WinLineManage(winBarView, winLinerView, _rollStopManage, overWinDisplay);
		}

		private function overTimeAutoPlayStopRollHandler(e:TimerEvent):void
		{
			if (_resultVo != null)
			{                //确认数据不为空
				_rollStopManage.autoStop();
			}
			else
			{
				_autoPlaytimer.reset();
				_autoPlaytimer.start();
				var _id:String;
				if (_freegameSoundNum > 0)
				{            //是否FREEGAME
					_id='400'; //游戏状态正常'200'freegame '400'
				}
				else
				{            //普通滚动声音
					_id='200'; //游戏状态正常'200'freegame '400'
				}
				//获取结果
				var _rp:ResultProxy=facade.retrieveProxy(ResultProxy.NAME) as ResultProxy;
				var _betP:BetProxy=facade.retrieveProxy(BetProxy.NAME) as BetProxy;
				var _betV:BetVo=_betP.getData() as BetVo;
				_rp.toGetData(_randomId.toString(), _id, _betV.betRate.toString(), _betV.lineNum.toString());
			}
		}

		//1.4.0
		private function overTimeManuallyStopRollHandler(e:TimerEvent):void
		{
			if (_resultVo != null)
			{                //确认数据不为空
				if (!isManuallyStop)
				{            //是否有点手动停
					_rollStopManage.autoStop();
				}
				else
				{
					_rollStopManage.manuallyStop(); //备用
				}
				_manuallytimer.stop();
				//发送停止手动点击命令
				sendNotification(STOP_MANUALLY_STOP_ROLL_COMMAND);
			}
			else
			{
				_manuallytimer.reset();
				_manuallytimer.start();
				var _id:String;
				if (_freegameSoundNum > 0)
				{            //是否FREEGAME
					_id='400'; //游戏状态正常'200'freegame '400'
				}
				else
				{            //普通滚动声音
					_id='200'; //游戏状态正常'200'freegame '400'
				}
				//获取结果
				var _rp:ResultProxy=facade.retrieveProxy(ResultProxy.NAME) as ResultProxy;
				var _betP:BetProxy=facade.retrieveProxy(BetProxy.NAME) as BetProxy;
				var _betV:BetVo=_betP.getData() as BetVo;
				_rp.toGetData(_randomId.toString(), _id, _betV.betRate.toString(), _betV.lineNum.toString());
			}
		}

		//1.4.0
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case ResultProxy.GIVE_RESULT_DATA:
					_resultVo=notification.getBody() as ResultVo;
					//取数据
					var _rs1:int=int(_resultVo.stopPosition[0]);
					var _rs2:int=int(_resultVo.stopPosition[1]);
					var _rs3:int=int(_resultVo.stopPosition[2]);
					var _rs4:int=int(_resultVo.stopPosition[3]);
					var _rs5:int=int(_resultVo.stopPosition[4]);
					_rollStopManage.setStopData(_rs1, _rs2, _rs3, _rs4, _rs5);
					/**********/
					if (AbstractMain.ALPHA_BG)
					{
						mask_1.height=459.4;
						mask_2.height=460.4;
						mask_3.height=460.25;
						mask_4.height=458.25;
						mask_5.height=459.8;

					}

					var _psp:PlayStateProxy=facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
					_playStateVo=_psp.getData() as PlayStateVo;
					if (_playStateVo.isManuallyPlay && isManuallyStop)
					{        //////是手动开始

						_rollStopManage.manuallyStop();
						_soundChannel.stop();
						isManuallyStop=false;
					}

					break;
				case RollControlCommand.START_ROLL_COMMAND:
					startRoll();
					break;
				//手动停止
				case RollControlCommand.STOP_ROLL_COMMAND:
					manuallyStopRoll();
					break;
				case WinJackpotMediator.OVER:
					overWinDisplay();
					break;
				// 断线重连后进入FreeGame
				case FreeGameProxy.GIVE_FREEGAME_DATA:
					var _freeGame:FreeGameProxy=facade.retrieveProxy(FreeGameProxy.NAME) as FreeGameProxy;
					var _fg:FreeGameVo=_freeGame.getData() as FreeGameVo;
					continueFreeGame(_fg);
					break;
				case LineBtnBarMediator.GIVE_SHOW_HIDE_LINE_DATA:
					var _lineVo:lineVo=notification.getBody() as lineVo;
					if (_lineVo.isShow)
					{
						_winLineManage.getLinerAndShow(_lineVo.lineNum); //显示线
					}
					else
					{
						_winLineManage.clearLiner(); // 隐藏线
					}
					break;
			}
		}

		//断线重连后进入FREEGAME 状态
		private function continueFreeGame(fg:FreeGameVo):void
		{
			//////是否中FREEGAME
			var _psp:PlayStateProxy=facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			_psp.toFreeGamePlayState();
			_freegameSoundNum=_freegameNum=fg.freeGameNum;

			_soundChannel=_sound.freeGameInSonud.play();
			//显示FREEGAME次数
			sendNotification(UPDATA_DISPLAY_FREEGAME_COMMAND, _freegameNum.toString());
			//转换背景(红)
			sendNotification(UPDATA_DISPLAY_BACKGROUND_COMMAND, DisplayBackgroundMediator.RED);
			_fristTimeinFreeGame=false;
			setTimeout(function():void
			{
				_sound.isSoundOver(_sound.freeGameInSonud, _soundChannel, gotoPlayFreeGame); //进入FREEGAME 声音
			}, 1000);
			//声音结束后运行
			function gotoPlayFreeGame():void
			{

				_freegameNum--;

				//继续滚动
				startRoll();
				//显示FREEGAME次数
				sendNotification(UPDATA_DISPLAY_FREEGAME_COMMAND, _freegameNum.toString());
			}
		}

		//中奖线显示完毕
		private function overWinDisplay():void
		{
			if (_resultVo.freeGameNum != 0) //如果第一次进入 
			{                ////是
				_sound.isSoundOver(_sound.hasFreeSpinSound, _soundChannel, overPlay);
			}
			else
			{
				if (_freegameNum > 0)
				{
					_sound.isSoundOver(_sound.freeGameWinSound, _soundChannel, overPlay);
				}
				else
				{
					_sound.isSoundOver(_sound.winSound, _soundChannel, overPlay);
				}
			}
		}

		//全局结束
		private function overPlay():void
		{
			var _psp:PlayStateProxy=facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			if (!isRoll)
			{
				if (_freegameNum == 0)
				{
					_psp.toStopFreeGamePlayState(); // 退出 freegame 状态
				}
				else
				{
					_psp.toFreeGamePlayState(); // freegame 状态
				}
				var _rollP:RollStateProxy=facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy; // 停止滚动状态
				var _rV:RollVo=new RollVo();
				_rV.isRolling=false;
				_rollP.setData(_rV);
				//更新Balance
				sendNotification(DisplayBalanceMediator.REQUEST_BALANCE_DATA_COMMAND);
				//是否FREEGAME
				if (_freegameNum > 0)
				{            ////是
					if (_fristTimeinFreeGame)
					{
						_soundChannel=_sound.freeGameInSonud.play();
						//转换背景(红)
						sendNotification(UPDATA_DISPLAY_BACKGROUND_COMMAND, DisplayBackgroundMediator.RED);
						_fristTimeinFreeGame=false;
						setTimeout(function():void
						{
							_sound.isSoundOver(_sound.freeGameInSonud, _soundChannel, gotoPlayFreeGame); //进入FREEGAME 声音
						}, 1000);
					}
					else
					{
						gotoPlayFreeGame();
					}
					//声音结束后运行
					function gotoPlayFreeGame():void
					{
						_freegameNum--;
						//继续滚动
						startRoll();
						//显示FREEGAME次数
						sendNotification(UPDATA_DISPLAY_FREEGAME_COMMAND, _freegameNum.toString());
					}
				}
				else
				{            ////否
					//trace("结束");
					//转换背景(黑)
					sendNotification(UPDATA_DISPLAY_BACKGROUND_COMMAND, DisplayBackgroundMediator.BLACK);
					_fristTimeinFreeGame=true;

					//是否Autoplay
					var _vo:PlayStateVo=_psp.getData() as PlayStateVo;

					if (_vo.isManuallyPlay)
					{

						// 手动停
						sendNotification(ROLL_OVER_EVENT);

						if (_resultVo.isWin && _resultVo.liners[0] != '-1' && _resultVo.liners[0] != '-2' && _resultVo.liners[0] != '-3' && _resultVo.liners[0] != '-4' && _resultVo.liners[0] != '-5' && _resultVo.liners[0] != '-6' && _resultVo.liners[0] != null)
						{    //////普通线

							_winLineManage.setWinLineData(_resultVo.liners);
							setTimeout(_winLineManage.showWinLine, 1);
						}
					}
					else
					{
						// 自动玩
						setTimeout(function():void
						{
							sendNotification(ROLL_OVER_EVENT);
						}, 400); // 不能太短，否则Blance 未得到数据
					}

					/*
					   setTimeout(function()
					   {
					   sendNotification(ROLL_OVER_EVENT);
					   //是否Autoplay
					   var _vo:PlayStateVo = _psp.getData() as PlayStateVo;
					   if (_vo.isManuallyPlay) {
					   if (_resultVo.isWin && _resultVo.liners[0] != '-1' && _resultVo.liners[0] != '-2' && _resultVo.liners[0] != '-3' && _resultVo.liners[0] != '-4' && _resultVo.liners[0] != '-5' && _resultVo.liners[0] != '-6' && _resultVo.liners[0] != null)
					   { //////普通线
					   _winLineManage.setWinLineData(_resultVo.liners);
					   setTimeout(_winLineManage.showWinLine, 1);
					   }

					   }
					 }, 400); // 不能太短，否则Blance 未得到数据*/
				}
			}
		}

		//停止滚动
		private function stopRoll():void
		{
			//trace("滚动停止");
			isRoll=false;
			//发确认数据信息
			var _srp:SetResultProxy=facade.retrieveProxy(SetResultProxy.NAME) as SetResultProxy;
			var _betP:BetProxy=facade.retrieveProxy(BetProxy.NAME) as BetProxy;
			var _betV:BetVo=_betP.getData() as BetVo;
			var isJackpot:String='0';
			if (int(_resultVo.liners[0]) < 0)
			{
				isJackpot=_resultVo.liners[0];
			}
			//修改4

			var _psp:PlayStateProxy=facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			var _pV:PlayStateVo=_psp.getData() as PlayStateVo;
			var _bet:Number;
			if (_pV.isfreegamePlay)
			{
				_bet=0;
			}
			else
			{
				_bet=_betV.betRate;
			}
			_srp.toGetData(_resultVo.win.toString(), _betV.lineNum.toString(), _bet.toString(), isJackpot);
			_rollStartManage.stopRoll(); //开始滚动控制器停止
			var _wV:WinVo=new WinVo();
			_wV.win=_resultVo.win;
			sendNotification(UPDATA_DISPLAY_WIN_COMMAND, _wV); //更新win display 信息,显示WIN 数值
			//判断中奖情况
			if (_resultVo.isWin)
			{                //是
				//播放游戏声音类型
				if (_freegameNum > 0) // FreeGame 类型
				{
					_soundChannel=_sound.freeGameWinSound.play();
				}            // JACKPOT类型
				else if (_resultVo.liners[0] == '-1' || _resultVo.liners[0] == '-2' || _resultVo.liners[0] == '-3' || _resultVo.liners[0] == '-4' || _resultVo.liners[0] == '-5' || _resultVo.liners[0] == '-6')
				{

					_soundChannel=_sound.jackpotSound.play();
				}            // 普通类型
				else
				{
					_soundChannel=_sound.winSound.play();
				}
				if (_resultVo.liners[0] != '-1' && _resultVo.liners[0] != '-2' && _resultVo.liners[0] != '-3' && _resultVo.liners[0] != '-4' && _resultVo.liners[0] != '-5' && _resultVo.liners[0] != '-6' && _resultVo.liners[0] != null)
				{            //////普通线
					setTimeout(showWinLine, 500);
					function showWinLine():void
					{
						_winLineManage.setWinLineData(_resultVo.liners);
						setTimeout(_winLineManage.showWinLine, 1000);
						if (_freegameNum == 0)
						{
							sendRollOverEvent();
						}
					}
				}
				else if (_resultVo.liners[0] == '-1' || _resultVo.liners[0] == '-2' || _resultVo.liners[0] == '-3')
				{            //////中普通JACKPOT
					sendNotification(WinJackpotMediator.SHOW, _wV);
					sendRollOverEvent();
				}
				else if (_resultVo.liners[0] == '-4')
				{
					//////中现金JACKPOT 1
					sendNotification(WinJackpotMediator.SHOW_JACKPOT_CASH_A);
					sendRollOverEvent();

				}
				else if (_resultVo.liners[0] == '-5')
				{
					//////中现金JACKPOT 2
					sendNotification(WinJackpotMediator.SHOW_JACKPOT_CASH_B);
					sendRollOverEvent();

				}
				else if (_resultVo.liners[0] == '-6')
				{
					//////中现金JACKPOT 3
					sendNotification(WinJackpotMediator.SHOW_JACKPOT_CASH_C);
					sendRollOverEvent();

				}
			}
			else if (_resultVo.freeGameNum != 0)
			{                //////是否中FREEGAME 
				_freegameSoundNum=_freegameNum=_freegameNum + _resultVo.freeGameNum;
				_soundChannel=_sound.hasFreeSpinSound.play();
				setTimeout(showfreegame, 800);
				function showfreegame():void
				{
					//显示FREEGAME次数
					sendNotification(UPDATA_DISPLAY_FREEGAME_COMMAND, _freegameNum.toString());
					_winLineManage.showFreeGame(); //显示FREEGAME 闪烁
				}
			}
			else
			{                //什么都没中
				overPlay();
			}
		}

		//发送停止信息
		private function sendRollOverEvent():void
		{
			var _psp:PlayStateProxy=facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			var _pV:PlayStateVo=_psp.getData() as PlayStateVo;
			if (!_pV.isAutoPlay)
			{
				setTimeout(function():void
				{
					var _rollP:RollStateProxy=facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy; // 停止滚动状态
					var _rV:RollVo=new RollVo();
					_rV.isRolling=false;
					_rollP.setData(_rV);
					//更新Balance
					sendNotification(DisplayBalanceMediator.REQUEST_BALANCE_DATA_COMMAND);
					sendNotification(ROLL_OVER_EVENT);
				}, 500);
			}
		}

		//手动停止
		//1.4.0
		private function manuallyStopRoll():void
		{

			_manuallytimer.stop();
			isManuallyStop=true;
			if (_resultVo != null)
			{                //确认数据不为空

				_rollStopManage.manuallyStop();
				_soundChannel.stop();
				isManuallyStop=false;
			}
			else
			{                //3.28
				//_manuallytimer.reset();
				//_manuallytimer.start();

			}

		}

		//1.4.0
		private function startRoll():void
		{
			isManuallyStop=false; //1.4.0
			var _rollP:RollStateProxy=facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy; // 开始滚动状态
			var _rV:RollVo=new RollVo();
			_rV.isRolling=true;
			_rollP.setData(_rV);
			isRoll=true;
			if (_soundChannel)
			{
				_soundChannel.stop();
			}
			_winLineManage.hideWinLine();
			_randomId++;
			//清除结果
			_playStateVo=null;
			_resultVo=null;
			//获取结果
			var _rp:ResultProxy=facade.retrieveProxy(ResultProxy.NAME) as ResultProxy;
			var _betP:BetProxy=facade.retrieveProxy(BetProxy.NAME) as BetProxy;
			var _betV:BetVo=_betP.getData() as BetVo;
			//随机ID;

			//BET;
			//LINE
			var _id:String;
			//播放游戏声音
			if (_freegameSoundNum > 0)
			{                //是否FREEGAME
				//播放FREEGAME 声音
				_freegameSoundNum--;
				_sound.freeGameStartRollSound.play();
				_id='400';   //游戏状态正常'200'freegame '400'
			}
			else
			{                //普通滚动声音
				_soundChannel=_sound.startRollSound.play();
				//滚从开始处理扣分
				sendNotification(ROLLING_START_PROCESSING);
				_id='200';   //游戏状态正常'200'freegame '400'
			}
			var _saveFgP:SaveFreeGameProxy=facade.retrieveProxy(SaveFreeGameProxy.NAME) as SaveFreeGameProxy;
			_saveFgP.toGetData(AbstractMain.GAME_ID, _betV.lineNum.toString(), _betV.betRate.toString(), _freegameNum.toString());

			_rp.toGetData(_randomId.toString(), _id, _betV.betRate.toString(), _betV.lineNum.toString());

			////判断是手动开始还是Autoplay 开始
			var _psp:PlayStateProxy=facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			_playStateVo=_psp.getData() as PlayStateVo;
			if (_playStateVo.isManuallyPlay)
			{                //////是手动开始
				_manuallytimer.reset();
				_manuallytimer.start();
			}
			else if (_playStateVo.isAutoPlay)
			{                //////是Autoplay 开始
				_autoPlaytimer.reset();
				_autoPlaytimer.start();
			}
			else if (_playStateVo.isfreegamePlay)
			{
				//////是freegame开始
				_autoPlaytimer.reset();
				_autoPlaytimer.start();

			}
			//是否AutoPlay 开始
			_rollStartManage.startRoll();

		}

		override public function listNotificationInterests():Array
		{
			return [
				//鼠标经过时显示隐藏线
				LineBtnBarMediator.GIVE_SHOW_HIDE_LINE_DATA,
				//得到结果信息
				ResultProxy.GIVE_RESULT_DATA,
				//start roll
				RollControlCommand.START_ROLL_COMMAND,
				//stop roll
				RollControlCommand.STOP_ROLL_COMMAND,
				//jackpot_fire 显示完成
				WinJackpotMediator.OVER, FreeGameProxy.GIVE_FREEGAME_DATA];
		}

		private function get mask_1():MovieClip
		{
			return rollBarView.getChildByName("__mask1") as MovieClip;
		}

		private function get mask_2():MovieClip
		{
			return rollBarView.getChildByName("__mask2") as MovieClip;
		}

		private function get mask_3():MovieClip
		{
			return rollBarView.getChildByName("__mask3") as MovieClip;
		}

		private function get mask_4():MovieClip
		{
			return rollBarView.getChildByName("__mask4") as MovieClip;
		}

		private function get mask_5():MovieClip
		{
			return rollBarView.getChildByName("__mask5") as MovieClip;
		}

		private function get winBarView():MovieClip
		{
			return viewComponent.__WinBar as MovieClip;
		}

		/**
		 * 线
		 * @return
		 *
		 */
		private function get winLinerView():MovieClip
		{
			return viewComponent.__WinLiner as MovieClip;
		}

		private function get rollStopContView():MovieClip
		{
			return viewComponent.__RollStopCont as MovieClip;

		}

		private function get rollCont_5View():MovieClip
		{

			return viewComponent.__Cont_5 as MovieClip;
		}

		private function get rollCont_4View():MovieClip
		{
			return viewComponent.__Cont_4 as MovieClip;
		}

		private function get rollCont_3View():MovieClip
		{
			return viewComponent.__Cont_3 as MovieClip;
		}

		private function get rollCont_2View():MovieClip
		{
			return viewComponent.__Cont_2 as MovieClip;
		}

		private function get rollCont_1View():MovieClip
		{
			return viewComponent.__Cont_1 as MovieClip;
		}

		private function get rollBarView():RollBar
		{
			return viewComponent as RollBar;
		}

	}

}
