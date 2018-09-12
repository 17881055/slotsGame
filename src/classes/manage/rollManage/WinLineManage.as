package classes.manage.rollManage
{
	import classes.Main;
	import classes.mediator.view.rollElement.BaseRollElementView;
	import classes.utli.UtliClearChild;
	import classes.utli.UtliColorTransformer;
	import classes.utli.UtliGC;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;

	/**
	 * ...
	 * @author Ethan
	 */
	public class WinLineManage implements IWinLine
	{
		static public const STOP:String="normal";
		static public const GO:String="go";
		private var _winBar:MovieClip;
		private var _winLiner:MovieClip;
		private var _winLinerColorDictionary:Dictionary; //中奖线颜色控制器
		private var _winLinerDictionary:Dictionary; //中奖线控制器
		private var _stopManage:IStopRoll;
		private var _stopLinesData:Vector.<String>;
		private var _winLinersData:Vector.<Vector.<BaseRollElementView>>; //中奖的元素数组
		private var _brightenData:Vector.<Vector.<BaseRollElementView>>; // 变亮的元素数组
		private var _freeGameData:Vector.<BaseRollElementView>; // FreeGame元素数组
		private var _ln:uint;
		private var _tn:uint;
		private var _overDisplayFunc:Function;
		private var isBreakOff:Boolean;
		private var _elementTotal:int;
		private var _elementCurrent:int;

		public function WinLineManage(winBar:MovieClip, winLiner:MovieClip, stopManage:IStopRoll, overDisplayFunc:Function)
		{
			_overDisplayFunc=overDisplayFunc;
			_winBar=winBar;
			_winLiner=winLiner;
			/////
			_stopManage=stopManage;
			init();
		}

		private function init():void
		{
			isBreakOff=false;
			_winLinerColorDictionary=new Dictionary();
//			setFormatWinLinerColor();
			_winLinerDictionary=new Dictionary();
			setFormatWinLiner();
		}

		private function setFormatWinLinerColor():void
		{
			_winLinerColorDictionary[1]=AbstractMain.LINE_COLOR[0];
			_winLinerColorDictionary[2]=AbstractMain.LINE_COLOR[1];
			_winLinerColorDictionary[3]=AbstractMain.LINE_COLOR[2];
			_winLinerColorDictionary[4]=AbstractMain.LINE_COLOR[3];
			_winLinerColorDictionary[5]=AbstractMain.LINE_COLOR[4];
			_winLinerColorDictionary[6]=AbstractMain.LINE_COLOR[5];
			_winLinerColorDictionary[7]=AbstractMain.LINE_COLOR[6];
			_winLinerColorDictionary[8]=AbstractMain.LINE_COLOR[7];
			_winLinerColorDictionary[9]=AbstractMain.LINE_COLOR[8];
			_winLinerColorDictionary[10]=AbstractMain.LINE_COLOR[9];
			_winLinerColorDictionary[11]=AbstractMain.LINE_COLOR[10];
			_winLinerColorDictionary[12]=AbstractMain.LINE_COLOR[11];
			_winLinerColorDictionary[13]=AbstractMain.LINE_COLOR[12];
			_winLinerColorDictionary[14]=AbstractMain.LINE_COLOR[13];
			_winLinerColorDictionary[15]=AbstractMain.LINE_COLOR[14];
			_winLinerColorDictionary[16]=AbstractMain.LINE_COLOR[15];
			_winLinerColorDictionary[17]=AbstractMain.LINE_COLOR[16];
			_winLinerColorDictionary[18]=AbstractMain.LINE_COLOR[17];
			_winLinerColorDictionary[19]=AbstractMain.LINE_COLOR[18];
			_winLinerColorDictionary[20]=AbstractMain.LINE_COLOR[19];
			_winLinerColorDictionary[21]=AbstractMain.LINE_COLOR[20];
			_winLinerColorDictionary[22]=AbstractMain.LINE_COLOR[21];
			_winLinerColorDictionary[23]=AbstractMain.LINE_COLOR[22];
			_winLinerColorDictionary[24]=AbstractMain.LINE_COLOR[23];
		}

		private function setFormatWinLiner():void
		{
			for (var i:uint=0; i < _winLiner.numChildren; i++)
			{
				_winLinerDictionary[i + 1]=_winLiner.getChildAt(i);
				_winLinerDictionary[i + 1].gotoAndStop(STOP);
			}
		}

		//返回中奖元素数组
		private function setWinResults():void
		{
			var v1:BaseRollElementView;
			var v2:BaseRollElementView;
			var v3:BaseRollElementView;
			var v4:BaseRollElementView;
			var v5:BaseRollElementView;
			for each (var _lines:String in _stopLinesData)
			{
				switch (_lines)
				{
					case '1':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(1, 2);
						v3=_stopManage.getRollElementView(1, 3);
						v4=_stopManage.getRollElementView(1, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '2':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(3, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '3':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(1, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(3, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
					case '4':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '5':
						v1=_stopManage.getRollElementView(2, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(2, 5);
						break;
					case '6':
						v1=_stopManage.getRollElementView(2, 1);
						v2=_stopManage.getRollElementView(3, 2);
						v3=_stopManage.getRollElementView(3, 3);
						v4=_stopManage.getRollElementView(3, 4);
						v5=_stopManage.getRollElementView(2, 5);
						break;
					case '7':
						v1=_stopManage.getRollElementView(2, 1);
						v2=_stopManage.getRollElementView(1, 2);
						v3=_stopManage.getRollElementView(1, 3);
						v4=_stopManage.getRollElementView(1, 4);
						v5=_stopManage.getRollElementView(2, 5);
						break;
					case '8':
						v1=_stopManage.getRollElementView(2, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(3, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '9':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(3, 2);
						v3=_stopManage.getRollElementView(3, 3);
						v4=_stopManage.getRollElementView(3, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
					case '10':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(1, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
					case '11':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(3, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(1, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '12':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
					case '13':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '14':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(3, 2);
						v3=_stopManage.getRollElementView(1, 3);
						v4=_stopManage.getRollElementView(3, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '15':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(1, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '16':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(3, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(3, 4);
						v5=_stopManage.getRollElementView(1, 5);
						break;
					case '17':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(1, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(3, 4);
						v5=_stopManage.getRollElementView(2, 5);
						break;
					case '18':
						v1=_stopManage.getRollElementView(2, 1);
						v2=_stopManage.getRollElementView(1, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(3, 4);
						v5=_stopManage.getRollElementView(2, 5);
						break;
					case '19':
						v1=_stopManage.getRollElementView(2, 1);
						v2=_stopManage.getRollElementView(3, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(1, 4);
						v5=_stopManage.getRollElementView(2, 5);
						break;
					case '20':
						v1=_stopManage.getRollElementView(2, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(3, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(2, 5);
						break;
					case '21':
						v1=_stopManage.getRollElementView(1, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(2, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
					case '22':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(1, 2);
						v3=_stopManage.getRollElementView(3, 3);
						v4=_stopManage.getRollElementView(1, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
					case '23':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(1, 2);
						v3=_stopManage.getRollElementView(1, 3);
						v4=_stopManage.getRollElementView(1, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
					case '24':
						v1=_stopManage.getRollElementView(3, 1);
						v2=_stopManage.getRollElementView(2, 2);
						v3=_stopManage.getRollElementView(3, 3);
						v4=_stopManage.getRollElementView(2, 4);
						v5=_stopManage.getRollElementView(3, 5);
						break;
				}
				_winLinersData.push(compare(v1, v2, v3, v4, v5));
				var _all:Vector.<BaseRollElementView>=new <BaseRollElementView>[v1, v2, v3, v4, v5];
				_brightenData.push(_all);
			}
		}

		private function setFreeGameResults():void
		{
			//freegame
			for (var r:int=1; r < 4; r++)
			{
				for (var c:int=1; c < 6; c++)
				{
					var _v:BaseRollElementView=_stopManage.getRollElementView(r, c);
					if (_v.name == "FreeSpin")
					{
						var _w:BaseRollElementView=_v.clone() as BaseRollElementView;
						var _wp:Point=_v.parent.localToGlobal(new Point(_v.x, _v.y));
						_w.x=_wp.x;
						_w.y=_wp.y;
						_freeGameData.push(_w);
					}
				}
			}
		}

		private function showFreeGameFunc():void
		{
			for (var i:uint=0; i < _freeGameData.length; i++)
			{
				var _e:BaseRollElementView=_freeGameData[i];
				_e.x=_winBar.globalToLocal(new Point(_e.x, _e.y)).x;
				_e.y=_winBar.globalToLocal(new Point(_e.x, _e.y)).y;
				var _s:Shape=new Shape(); //背景

				if (AbstractMain.ALPHA_BG)
				{
					_s.graphics.beginFill(0xFFFFFF, 0);
				}
				else
				{

					_s.graphics.beginFill(0xFFFFFF, 1);
				}

				_s.graphics.drawRect(_e.x, _e.y, _e.width, _e.height);
				_s.graphics.endFill();
				_winBar.addChild(_s);
				_winBar.addChild(_e);
				_e.victorState();
			}
			setTimeout(overFreeGame, 1500);
			function overFreeGame()
			{
				UtliClearChild.clearChildren(_winBar);
				_overDisplayFunc();
			}
		}

		private function compare(v1:BaseRollElementView, v2:BaseRollElementView, v3:BaseRollElementView, v4:BaseRollElementView, v5:BaseRollElementView):Vector.<BaseRollElementView>
		{
			var _repeat:Vector.<BaseRollElementView>=new Vector.<BaseRollElementView>; //记录重复的元素

			var _v1:BaseRollElementView=v1.clone();
			var _v1p:Point=v1.parent.localToGlobal(new Point(v1.x, v1.y));
			_v1.x=_v1p.x;
			_v1.y=_v1p.y;
			_repeat.push(_v1);
			var _v2:BaseRollElementView=v2.clone();
			var _v2p:Point=v2.parent.localToGlobal(new Point(v2.x, v2.y));
			_v2.x=_v2p.x;
			_v2.y=_v2p.y;
			_repeat.push(_v2);
			var _v3:BaseRollElementView=v3.clone();
			var _v3p:Point=v3.parent.localToGlobal(new Point(v3.x, v3.y));
			_v3.x=_v3p.x;
			_v3.y=_v3p.y;
			_repeat.push(_v3);

			if (v4.name == v1.name || v4.name == "Wild")
			{

				var _v4:BaseRollElementView=v4.clone();
				var _v4p:Point=v4.parent.localToGlobal(new Point(v4.x, v4.y));
				_v4.x=_v4p.x;
				_v4.y=_v4p.y;
				_repeat.push(_v4);

				if (v5.name == v1.name || v5.name == "Wild")
				{
					var _v5:BaseRollElementView=v5.clone();
					var _v5p:Point=v5.parent.localToGlobal(new Point(v5.x, v5.y));
					_v5.x=_v5p.x;
					_v5.y=_v5p.y;
					_repeat.push(_v5);
				}
			}

			return _repeat;  //返回 重复的元素
		}

		/* 获取索引号的线并显示
		* @param value
		*
		*/
		public function getLinerAndShow(value:uint):void
		{
			getLiner(value).gotoAndStop(GO);
		}

		/**
		 * 获取索引号的线
		 * @param value
		 * @return
		 *
		 */
		private function getLiner(value:uint):MovieClip
		{
			return _winLinerDictionary[value];
		}

		private function getLinerColor(value:uint):uint
		{
			return _winLinerColorDictionary[value];
		}

		/**
		 * 隐藏线
		 */
		public function clearLiner():void
		{
			for each (var wl:MovieClip in _winLinerDictionary)
			{
				wl.gotoAndStop(STOP);
			}
		}

		//根据中奖线显示线上的元素变亮
		private function brightenByLine(ln:int):void
		{
			//停止框所有元素变暗
			_stopManage.darken();
			for (var i:uint=0; i < _brightenData[ln].length; i++)
			{
				var _e:BaseRollElementView=_brightenData[ln][i];
				UtliColorTransformer.colorTransformer(_e);
			}
		}

		private function showLineFunc():void
		{
			if (!isBreakOff)
			{
				clearLiner();
				UtliClearChild.clearChildren(_winBar);
				if (_tn > _ln) //是否已完成所有线
				{
					showSingleLineFunc(uint(_stopLinesData[_ln]), _ln);
					_ln++;   //当前次数,当前显示线增加 
				}
				else
				{            //显示完成
					_overDisplayFunc();
				}
			}
		}

		private function showSingleLineFunc(value:uint, ln:int):void
		{
			var _wilds:Vector.<BaseRollElementView>=new Vector.<BaseRollElementView>;
			//根据中奖线显示线上的元素变亮
			brightenByLine(ln);
			//单条显示线
			getLiner(value).gotoAndStop(GO);
			//加元素&显示单个元素
			_elementTotal=_winLinersData[ln].length;
			_elementCurrent=0;
			for (var i:uint=0; i < _winLinersData[ln].length; i++)
			{

				var _e:BaseRollElementView=_winLinersData[ln][i];

				_e.addEventListener("ShowOver", overHandler, false, 0, true);
				_e.addFrameScript(_e.totalFrames - 1, addEvent);
				if (_e.name == "Wild")
				{
					_wilds.push(_e);
					_e.addFrameScript(_e.totalFrames - 2, addWildEvent);

				}
				function addWildEvent():void
				{
					for (var ii:uint=0; ii < _wilds.length; ii++)
					{
						_wilds[ii].visible=false;
					}
				}
				function addEvent():void
				{
					_e.dispatchEvent(new Event("ShowOver"));
				}
				_e.x=_winBar.globalToLocal(new Point(_e.x, _e.y)).x;
				_e.y=_winBar.globalToLocal(new Point(_e.x, _e.y)).y;

				_winBar.addChild(_e);
				_e.victorState();
			}                //单个元素显示完成

			for (var ii:uint=0; ii < _wilds.length; ii++)
			{
				_wilds[ii].addEventListener(Event.ENTER_FRAME, onEnterHandler);
				_wilds[ii].addEventListener(Event.REMOVED, onRemovedHandler);
				_winBar.setChildIndex(_wilds[ii], _winBar.numChildren - 1);

			}
			//继续显示下条线

		}

		private function onRemovedHandler(e:Event):void
		{
			e.target.removeEventListener(Event.REMOVED, onRemovedHandler);
			e.target.removeEventListener(Event.ENTER_FRAME, onEnterHandler);
		}

		private function onEnterHandler(e:Event):void
		{
			var _h:Number=152;
			if (e.target.y > 0)
			{
				e.target.y-=(e.target.height - _h) * .4;
				_h=e.target.height;

			}
			else
			{
				e.target.y=0;
			}

		}

		private function overHandler(e:Event):void
		{
			var _e:BaseRollElementView=e.target as BaseRollElementView;

			_elementCurrent++;
			if (_elementTotal == _elementCurrent)
			{
				// 900毫秒,每条线显示时间间隔
				setTimeout(showLineFunc, 500);
			}
		}

		/* INTERFACE classes.mediator.middleBar.rollManage.IWinLine */

		public function showWinLine():void
		{
			showLineFunc();
		}

		public function showFreeGame():void
		{
			UtliGC.todo();
			_freeGameData=new Vector.<BaseRollElementView>();
			setFreeGameResults();
			showFreeGameFunc();
		}

		public function hideFreeGame():void
		{
			_freeGameData=null;
			UtliClearChild.clearChildren(_winBar);

		}

		public function hideWinLine():void
		{
			clearLiner();
			UtliClearChild.clearChildren(_winBar);
			isBreakOff=true;
		}

		public function setWinLineData(winLines:Vector.<String>):void
		{

			UtliGC.todo();
			_stopLinesData=winLines;
			_winLinersData=new Vector.<Vector.<BaseRollElementView>>();
			_brightenData=new Vector.<Vector.<BaseRollElementView>>();
			setWinResults();
			_ln=0;
			_tn=_stopLinesData.length;
			isBreakOff=false;
		}

	}

}
