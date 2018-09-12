package classes.mediator.middleBar
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import classes.command.RollControlCommand;
	import classes.mediator.bottomBar.LinesBarMediator;
	import classes.proxy.FreeGameProxy;
	import classes.proxy.vo.BetVo;
	import classes.proxy.vo.lineVo;
	import classes.utli.UtliMouseEventSpecial;
	import classes.utli.UtliSoundManage;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * ...
	 * @author Ethan
	 */
	public class LineBtnBarMediator extends Mediator implements IMediator
	{
		public static const NAME:String="LineBtnBarMediator";
		public static const GIVE_LINE_DATA:String="GiveLineData";
		/**
		 * 鼠标经过显示线，离开隐藏线命令名称
		 */
		public static const GIVE_SHOW_HIDE_LINE_DATA:String="GiveShowHideLineData";
		private var _lineBtns:Vector.<MovieClip>;
		private var _lineBtnsControl:Vector.<UtliMouseEventSpecial>;
		private var _pointer:uint;

		public function LineBtnBarMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			init();
		}

		private function init():void
		{
			_lineBtnsControl=new Vector.<UtliMouseEventSpecial>;
			_lineBtns=new <MovieClip>[linebtn_1, linebtn_2,
									  linebtn_3, linebtn_4, linebtn_5, linebtn_6,
									  linebtn_7, linebtn_8, linebtn_9, linebtn_10,
									  linebtn_11, linebtn_12, linebtn_13, linebtn_14,
									  linebtn_15, linebtn_16, linebtn_17, linebtn_18,
									  linebtn_19, linebtn_20, linebtn_21, linebtn_22,
									  linebtn_23, linebtn_24, linebtn_25, linebtn_26,
									  linebtn_27, linebtn_28, linebtn_29, linebtn_30,
									  linebtn_31, linebtn_32, linebtn_33, linebtn_34,
									  linebtn_35, linebtn_36, linebtn_37, linebtn_38,
									  linebtn_39, linebtn_40, linebtn_41, linebtn_42,
									  linebtn_43, linebtn_44, linebtn_45, linebtn_46,
									  linebtn_47, linebtn_48, linebtn_49, linebtn_50];
			for each (var _lb:MovieClip in _lineBtns)
			{
				_lb.num=_lb.name.substr(7); //编号
				var _mouseEvent:UtliMouseEventSpecial=new UtliMouseEventSpecial(_lb, onMouseHandler);
				_lineBtnsControl.push(_mouseEvent);
			}
			setLineAmount=uint(_lineBtns.length)
			stopMouseEvent();

		}

		private function onMouseHandler(target:MovieClip, e:MouseEvent):void
		{
			var _lineVo:lineVo=new lineVo();
			_lineVo.lineNum=uint(target.num);
			switch (e.type)
			{
				case MouseEvent.CLICK: //点击
					var _bv:BetVo=new BetVo();
					setLineAmount=_bv.lineNum=uint(target.num);
					//send
					sendNotification(GIVE_LINE_DATA, _bv);
					//sound
					var _us:UtliSoundManage=UtliSoundManage.getInstance();
					_us.addSound.play();
					break;
				case MouseEvent.MOUSE_OVER: //经过
					_lineVo.isShow=true;
					sendNotification(GIVE_SHOW_HIDE_LINE_DATA, _lineVo);
					//出现线
					break;
				case MouseEvent.MOUSE_OUT: //离开
					//隐藏线
					_lineVo.isShow=false;
					sendNotification(GIVE_SHOW_HIDE_LINE_DATA, _lineVo);
					break;
			}


		}

		private function set setLineAmount(value:uint):void
		{
			_pointer=value;
			for (var _i:int=0; _i < _lineBtns.length; _i++)
			{
				if (_i < _pointer)
				{
					_lineBtnsControl[_i].select();
				}
				else
				{
					_lineBtnsControl[_i].unselect();
				}
			}

		}

		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case LinesBarMediator.GIVE_LINE_DATA:
					var _bv:BetVo=notification.getBody() as BetVo;
					setLineAmount=_bv.lineNum;
					break;
				case RollControlCommand.CLOSE_LINE_OPERATE_COMMAND:
					stopMouseEvent();
					break;
				case RollControlCommand.OPEN_LINE_COMMAND:
					startMouseEvent();
					break;
				case FreeGameProxy.GIVE_FREEGAME_DATA:
					stopMouseEvent();
					break;
			}
		}

		private function startMouseEvent():void
		{
			for (var _i:int=0; _i < _lineBtns.length; _i++)
			{
				_lineBtnsControl[_i].ableClick();
			}
		}

		/**
		 *
		 */
		private function stopMouseEvent():void
		{
			for (var _i:int=0; _i < _lineBtns.length; _i++)
			{
				_lineBtnsControl[_i].stopClick();
			}
		}

		override public function listNotificationInterests():Array
		{
			return [LinesBarMediator.GIVE_LINE_DATA, RollControlCommand.CLOSE_LINE_OPERATE_COMMAND, RollControlCommand.OPEN_LINE_COMMAND, FreeGameProxy.GIVE_FREEGAME_DATA];
		}

		private function get linebtn_1():MovieClip
		{
			return viewComponent.__Line_1;
		}

		private function get linebtn_2():MovieClip
		{
			return viewComponent.__Line_2;
		}

		private function get linebtn_3():MovieClip
		{
			return viewComponent.__Line_3;
		}

		private function get linebtn_4():MovieClip
		{
			return viewComponent.__Line_4;
		}

		private function get linebtn_5():MovieClip
		{
			return viewComponent.__Line_5;
		}

		private function get linebtn_6():MovieClip
		{
			return viewComponent.__Line_6;
		}

		private function get linebtn_7():MovieClip
		{
			return viewComponent.__Line_7;
		}

		private function get linebtn_8():MovieClip
		{
			return viewComponent.__Line_8;
		}

		private function get linebtn_9():MovieClip
		{
			return viewComponent.__Line_9;
		}

		private function get linebtn_10():MovieClip
		{
			return viewComponent.__Line_10;
		}

		private function get linebtn_11():MovieClip
		{
			return viewComponent.__Line_11;
		}

		private function get linebtn_12():MovieClip
		{
			return viewComponent.__Line_12;
		}

		private function get linebtn_13():MovieClip
		{
			return viewComponent.__Line_13;
		}

		private function get linebtn_14():MovieClip
		{
			return viewComponent.__Line_14;
		}

		private function get linebtn_15():MovieClip
		{
			return viewComponent.__Line_15;
		}

		private function get linebtn_16():MovieClip
		{
			return viewComponent.__Line_16;
		}

		private function get linebtn_17():MovieClip
		{
			return viewComponent.__Line_17;
		}

		private function get linebtn_18():MovieClip
		{
			return viewComponent.__Line_18;
		}

		private function get linebtn_19():MovieClip
		{
			return viewComponent.__Line_19;
		}

		private function get linebtn_20():MovieClip
		{
			return viewComponent.__Line_20;
		}

		private function get linebtn_21():MovieClip
		{
			return viewComponent.__Line_21;
		}

		private function get linebtn_22():MovieClip
		{
			return viewComponent.__Line_22;
		}

		private function get linebtn_23():MovieClip
		{
			return viewComponent.__Line_23;
		}

		private function get linebtn_24():MovieClip
		{
			return viewComponent.__Line_24;
		}

		private function get linebtn_25():MovieClip
		{
			return viewComponent.__Line_25;
		}

		private function get linebtn_26():MovieClip
		{
			return viewComponent.__Line_26;
		}

		private function get linebtn_27():MovieClip
		{
			return viewComponent.__Line_27;
		}

		private function get linebtn_28():MovieClip
		{
			return viewComponent.__Line_28;
		}

		private function get linebtn_29():MovieClip
		{
			return viewComponent.__Line_29;
		}

		private function get linebtn_30():MovieClip
		{
			return viewComponent.__Line_30;
		}

		private function get linebtn_31():MovieClip
		{
			return viewComponent.__Line_31;
		}

		private function get linebtn_32():MovieClip
		{
			return viewComponent.__Line_32;
		}

		private function get linebtn_33():MovieClip
		{
			return viewComponent.__Line_33;
		}

		private function get linebtn_34():MovieClip
		{
			return viewComponent.__Line_34;
		}

		private function get linebtn_35():MovieClip
		{
			return viewComponent.__Line_35;
		}

		private function get linebtn_36():MovieClip
		{
			return viewComponent.__Line_36;
		}

		private function get linebtn_37():MovieClip
		{
			return viewComponent.__Line_37;
		}

		private function get linebtn_38():MovieClip
		{
			return viewComponent.__Line_38;
		}

		private function get linebtn_39():MovieClip
		{
			return viewComponent.__Line_39;
		}

		private function get linebtn_40():MovieClip
		{
			return viewComponent.__Line_40;
		}

		private function get linebtn_41():MovieClip
		{
			return viewComponent.__Line_41;
		}

		private function get linebtn_42():MovieClip
		{
			return viewComponent.__Line_42;
		}

		private function get linebtn_43():MovieClip
		{
			return viewComponent.__Line_43;
		}

		private function get linebtn_44():MovieClip
		{
			return viewComponent.__Line_44;
		}

		private function get linebtn_45():MovieClip
		{
			return viewComponent.__Line_45;
		}

		private function get linebtn_46():MovieClip
		{
			return viewComponent.__Line_46;
		}

		private function get linebtn_47():MovieClip
		{
			return viewComponent.__Line_47;
		}

		private function get linebtn_48():MovieClip
		{
			return viewComponent.__Line_48;
		}

		private function get linebtn_49():MovieClip
		{
			return viewComponent.__Line_49;
		}

		private function get linebtn_50():MovieClip
		{
			return viewComponent.__Line_50;
		}


		private function get lineBtnBarView():Sprite
		{
			return viewComponent as Sprite;
		}
	}
}
