package classes.manage.rollManage
{
	import classes.mediator.view.RollBarView;
	import classes.mediator.view.rollElement.BaseRollElementView;
	import classes.manage.RollManageView;
	import classes.utli.UtliClearChild;
	import classes.utli.UtliColorTransformer;
	import classes.utli.UtliSoundManage;
	import com.greensock.easing.Cubic;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class RollStopManage implements IStopRoll
	{
		private var _stopWin:MovieClip;
		private var _startManage:RollStartManage;
		private var _stopCR_1:Vector.<BaseRollElementView>;
		private var _stopCR_2:Vector.<BaseRollElementView>;
		private var _stopCR_3:Vector.<BaseRollElementView>;
		private var _stopCR_4:Vector.<BaseRollElementView>;
		private var _stopCR_5:Vector.<BaseRollElementView>;
		private var _stopCRs:Vector.<Vector.<BaseRollElementView>>;
		private var _sC_1:MovieClip;
		private var _sC_2:MovieClip;
		private var _sC_3:MovieClip;
		private var _sC_4:MovieClip;
		private var _sC_5:MovieClip;
		private var _sCs:Vector.<MovieClip>;
		private const STOP_TIME:Number = .2;
		private var _overFunc:Function;
		private var _num:uint;
		private var _sound:UtliSoundManage;
		
		public function RollStopManage(stopWin:MovieClip, startManage:IRoll, overFunc:Function)
		{
			_sound = UtliSoundManage.getInstance();
			_overFunc = overFunc;
			_stopWin = stopWin;
			_startManage = startManage as RollStartManage;
			_sCs = new Vector.<MovieClip>;
			_sC_1 = new MovieClip();
			_sC_2 = new MovieClip();
			_sC_3 = new MovieClip();
			_sC_4 = new MovieClip();
			_sC_5 = new MovieClip();
			_sCs.push(_sC_1, _sC_2, _sC_3, _sC_4, _sC_5);
			for (var i:uint = 0; i < _sCs.length; i++)
			{
				_stopWin.addChild(_sCs[i]);
				_sCs[i].x = _startManage.getRCView_x(i);
				_sCs[i].y = -460;
			}
		}
		
		private function init():void
		{
			for (var j:uint = 0; j < _sCs.length; j++)
			{
				UtliClearChild.clearChildren(_sCs[j]);
			}
			_stopCR_1 = new Vector.<BaseRollElementView>;
			_stopCR_2 = new Vector.<BaseRollElementView>;
			_stopCR_3 = new Vector.<BaseRollElementView>;
			_stopCR_4 = new Vector.<BaseRollElementView>;
			_stopCR_5 = new Vector.<BaseRollElementView>;
			_stopCRs = new Vector.<Vector.<BaseRollElementView>>;
			for (var i:uint = 0; i < _sCs.length; i++)
			{
				_sCs[i].alpha = 0;
				_sCs[i].y = -460;
			}
		}
		
		private function setStopCR(target:RollBarView, stopCRs:Vector.<BaseRollElementView>, value:int):void
		{
			var _sCRs:Vector.<BaseRollElementView> = stopCRs;
			var _e1:BaseRollElementView = target.getElement(value - 1);
			var _e2:BaseRollElementView = target.getElement(value);
			var _e3:BaseRollElementView = target.getElement(value + 1);
			_sCRs.push(_e1, _e2, _e3);
			_stopCRs.push(_sCRs);
		}
		
		private function addToStopWin():void
		{
			for (var i:uint = 0; i < _sCs.length; i++)
			{
				var _s:Shape = new Shape();
				var _c:uint = AbstractMain.BG_COLOR;
				
				if (AbstractMain.ALPHA_BG)
				{
					
					_s.graphics.beginFill(_c, 0);
				}
				else
				{
					
					_s.graphics.beginFill(_c, 1);
					
				}
				
				if (AbstractMain.GAME_NAME == "Cards")
				{
					_s.graphics.drawRect(0, -100, 126, 565);
				}
				else
				{
					_s.graphics.drawRect(0, -100, 142, 565);
				}
				
				_s.graphics.endFill();
				_sCs[i].addChild(_s);
				for (var j:uint = 0; j < _stopCRs[i].length; j++)
				{
					_sCs[i].addChild(_stopCRs[i][j]);
					_stopCRs[i][j].x = 0;
					_stopCRs[i][j].y = j * RollManageView.ELEMENT_HEIGHT;
				}
			}
		}
		
		/* INTERFACE classes.mediator.middleBar.rollManage.IStopRoll */
		public function setStopData(value_1:int, value_2:int, value_3:int, value_4:int, value_5:int):void
		{
			init();
			_num = 0;
			setStopCR(_startManage.rollPlace_1, _stopCR_1, value_1);
			setStopCR(_startManage.rollPlace_2, _stopCR_2, value_2);
			setStopCR(_startManage.rollPlace_3, _stopCR_3, value_3);
			setStopCR(_startManage.rollPlace_4, _stopCR_4, value_4);
			setStopCR(_startManage.rollPlace_5, _stopCR_5, value_5);
			addToStopWin();
		}
		
		// 变暗
		public function darken():void
		{
			
			for (var i:uint = 0; i < _sCs.length; i++)
			{
				for (var j:uint = 0; j < _stopCRs[i].length; j++)
				{
					UtliColorTransformer.colorTransformer(_stopCRs[i][j], 0.2);
					
				}
			}
		}
		
		// 恢复正常
		public function undarken():void
		{
			
			for (var i:uint = 0; i < _sCs.length; i++)
			{
				for (var j:uint = 0; j < _stopCRs[i].length; j++)
				{
					UtliColorTransformer.colorTransformer(_stopCRs[i][j], 1);
				}
			}
		
		}
		
		public function manuallyStop():void // 五列一起停止
		{
			_sound.stopRollSound.play();
			for (var i:uint = 0; i < _sCs.length; i++)
			{
				if (AbstractMain.GAME_NAME == "GoldFactory" || AbstractMain.GAME_NAME == "VegasNight")
				{
					TweenLite.to(_sCs[i], STOP_TIME - 0.09, {y: 3, alpha: 1, delay: Math.random() * 0.1 + 0.1, onComplete: backFun, onCompleteParams: [_sCs[i]]});
				}
				else if (AbstractMain.GAME_NAME == "PubFruit")
				{
					TweenLite.to(_sCs[i], STOP_TIME - 0.09, {y: 5, alpha: 1, delay: Math.random() * 0.1 + 0.1, onComplete: backFun, onCompleteParams: [_sCs[i]]});
				}
				else
				{
					TweenLite.to(_sCs[i], STOP_TIME - 0.09, {y: 7, alpha: 1, delay: Math.random() * 0.1 + 0.1, onComplete: backFun, onCompleteParams: [_sCs[i]]});
				}
				
			}
			function backFun(value:MovieClip):void
			{
				TweenLite.to(value, .05, {y: 0, ease: Cubic.easeIn, onComplete: autoStopOver});
			}
			function autoStopOver():void
			{
				_num++;
				if (_num == 4)
				{
					_overFunc();
				}
			}
		}
		
		public function autoStop():void // 一列一列停止
		{
			
			var _time:int;
			if (AbstractMain.GAME_NAME == "GoldFactory" || AbstractMain.GAME_NAME == "PubFruit" || AbstractMain.GAME_NAME == "VegasNight")
			{
				_time = 5
			}
			else
			{
				_time = 7
			}
			
			_sound.stopRollSound.play();
			TweenLite.to(_sCs[0], STOP_TIME, {y: _time, alpha: 1, onComplete: backFun_1, onCompleteParams: [_sCs[0]]});
			function backFun_1(value:MovieClip):void
			{
				TweenLite.to(value, .05, {y: 0, ease: Cubic.easeIn, onComplete: go_2});
			}
			function go_2():void
			{
				TweenLite.to(_sCs[1], STOP_TIME, {y: _time, alpha: 1, onComplete: backFun_2, onCompleteParams: [_sCs[1]]});
			}
			function backFun_2(value:MovieClip):void
			{
				TweenLite.to(value, .05, {y: 0, ease: Cubic.easeIn, onComplete: go_3});
			}
			function go_3():void
			{
				TweenLite.to(_sCs[2], STOP_TIME, {y: _time, alpha: 1, onComplete: backFun_3, onCompleteParams: [_sCs[2]]});
			}
			function backFun_3(value:MovieClip):void
			{
				TweenLite.to(value, .05, {y: 0, ease: Cubic.easeIn, onComplete: go_4});
			}
			function go_4():void
			{
				TweenLite.to(_sCs[3], STOP_TIME, {y: _time, alpha: 1, onComplete: backFun_4, onCompleteParams: [_sCs[3]]});
			}
			function backFun_4(value:MovieClip):void
			{
				TweenLite.to(value, .05, {y: 0, ease: Cubic.easeIn, onComplete: go_5});
			}
			function go_5():void
			{
				TweenLite.to(_sCs[4], STOP_TIME, {y: _time, alpha: 1, onComplete: backFun_5, onCompleteParams: [_sCs[4]]});
			}
			function backFun_5(value:MovieClip):void
			{
				TweenLite.to(value, .05, {y: 0, ease: Cubic.easeIn, onComplete: manuallyStopOver});
			}
			function manuallyStopOver():void
			{
				_overFunc();
			}
		}
		
		/*rows 行
		 column 列*/
		public function getRollElementView(rows:uint, column:uint):BaseRollElementView
		{
			
			if (rows >= 1 && column >= 1 && rows < 4 && column < 6)
			{
				return _stopCRs[column - 1][rows - 1];
			}
			else
			{
				return _stopCRs[0][0];
			}
		}
	
	}

}