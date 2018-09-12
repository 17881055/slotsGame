package classes.manage.rollManage
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	import classes.Main;
	import classes.mediator.view.RollBarView;
	import classes.manage.RollManageView;
	import classes.utli.UtliGC;

	/**
	 * ...
	 * @author Ethan
	 */
	public class RollStartManage implements IRoll
	{
		private var _rC_1View:MovieClip;
		private var _rC_2View:MovieClip;
		private var _rC_3View:MovieClip;
		private var _rC_4View:MovieClip;
		private var _rC_5View:MovieClip;
		private var _rCs:Dictionary;
		private var _rP_1:RollBarView;
		private var _rP_2:RollBarView;
		private var _rP_3:RollBarView;
		private var _rP_4:RollBarView;
		private var _rP_5:RollBarView;
		private var _rCP_1:RollBarView;
		private var _rCP_2:RollBarView;
		private var _rCP_3:RollBarView;
		private var _rCP_4:RollBarView;
		private var _rCP_5:RollBarView;
		private var _stage:Sprite;
		//默认速度
		private var _sp:uint=AbstractMain.SPEED;
		private var _timer:Timer;
		private var _Mh:Number=500;

		public function RollStartManage(stage:Sprite, cont1:MovieClip, cont2:MovieClip, cont3:MovieClip, cont4:MovieClip, cont5:MovieClip)
		{
			_stage=stage;
			_rC_1View=cont1;
			_rC_2View=cont2;
			_rC_3View=cont3;
			_rC_4View=cont4;
			_rC_5View=cont5;

			_rCs=new Dictionary();
			_rCs["0"]=_rC_1View;
			_rCs["1"]=_rC_2View;
			_rCs["2"]=_rC_3View;
			_rCs["3"]=_rC_4View;
			_rCs["4"]=_rC_5View;
			init();
		}

		private function init():void
		{
			_timer=new Timer(15, 0);
			_timer.addEventListener(TimerEvent.TIMER, onEnterFrameHandler);
			regeditRollCont();
			regeditRollCopyCont();
		}

		private function regeditRollCont():void
		{
			var _rmv:RollManageView=new RollManageView();
			_rC_1View.addChild(_rP_1=_rmv.rollBar_1View);
			_rC_2View.addChild(_rP_2=_rmv.rollBar_2View);
			_rC_3View.addChild(_rP_3=_rmv.rollBar_3View);
			_rC_4View.addChild(_rP_4=_rmv.rollBar_4View);
			_rC_5View.addChild(_rP_5=_rmv.rollBar_5View);
		}

		private function regeditRollCopyCont():void
		{
			var _crmv:RollManageView=new RollManageView();
			_rC_1View.addChild(_rCP_1=_crmv.rollBar_1View);
			_rC_2View.addChild(_rCP_2=_crmv.rollBar_2View);
			_rC_3View.addChild(_rCP_3=_crmv.rollBar_3View);
			_rC_4View.addChild(_rCP_4=_crmv.rollBar_4View);
			_rC_5View.addChild(_rCP_5=_crmv.rollBar_5View);
			setCopyPlaceY();
		}

		private function setCopyPlaceY():void
		{
			_rCP_1.y=_rP_1.y - _rCP_1.height;
			_rCP_2.y=_rP_2.y - _rCP_2.height;
			_rCP_3.y=_rP_3.y - _rCP_3.height;
			_rCP_4.y=_rP_4.y - _rCP_4.height;
			_rCP_5.y=_rP_5.y - _rCP_5.height;
		}

		/* INTERFACE classes.mediator.middleBar.rollManage.IRoll */

		public function startRoll():void
		{
			//UtliGC.todo();//GC
			_timer.start();
		}

		public function stopRoll():void
		{
			_timer.stop();
		}

		private function onEnterFrameHandler(e:TimerEvent):void
		{
			_rP_1.y+=_sp;
			_rP_2.y+=_sp;
			_rP_3.y+=_sp;
			_rP_4.y+=_sp;
			_rP_5.y+=_sp;
			_rCP_1.y+=_sp;
			_rCP_2.y+=_sp;
			_rCP_3.y+=_sp;
			_rCP_4.y+=_sp;
			_rCP_5.y+=_sp;
			if (_rP_1.y > _Mh)
				_rP_1.y=_rCP_1.y - _rCP_1.height;
			if (_rP_2.y > _Mh)
				_rP_2.y=_rCP_2.y - _rCP_2.height;
			if (_rP_3.y > _Mh)
				_rP_3.y=_rCP_3.y - _rCP_3.height;
			if (_rP_4.y > _Mh)
				_rP_4.y=_rCP_4.y - _rCP_4.height;
			if (_rP_5.y > _Mh)
				_rP_5.y=_rCP_5.y - _rCP_5.height;
			if (_rCP_1.y > _Mh)
				_rCP_1.y=_rP_1.y - _rP_1.height;
			if (_rCP_2.y > _Mh)
				_rCP_2.y=_rP_2.y - _rP_2.height;
			if (_rCP_3.y > _Mh)
				_rCP_3.y=_rP_3.y - _rP_3.height;
			if (_rCP_4.y > _Mh)
				_rCP_4.y=_rP_4.y - _rP_4.height;
			if (_rCP_5.y > _Mh)
				_rCP_5.y=_rP_5.y - _rP_5.height;
			e.updateAfterEvent();
		}

		public function get rollPlace_1():RollBarView
		{
			return _rP_1;
		}

		public function get rollPlace_2():RollBarView
		{
			return _rP_2;
		}

		public function get rollPlace_3():RollBarView
		{
			return _rP_3;
		}

		public function get rollPlace_4():RollBarView
		{
			return _rP_4;
		}

		public function get rollPlace_5():RollBarView
		{
			return _rP_5;
		}

		public function get speed():Number
		{
			return _sp;
		}

		public function set speed(value:Number):void
		{
			_sp=value;
		}

		public function getRCView_x(value:int):Number
		{
			var _rCView:MovieClip=_rCs[value.toString()];
			return _rCView.x;
		}

	}

}
