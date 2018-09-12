package classes.mediator.bottomBar
{
	import classes.proxy.PlayStateProxy;
	import classes.proxy.RollStateProxy;
	import classes.proxy.vo.PlayStateVo;
	import classes.proxy.vo.RollVo;
	import classes.utli.socket.AddListenerSocket;
	import classes.utli.UtliMouseClick;
	import flash.display.MovieClip;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BtnBackMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BtnBackMediator";
		
		public function BtnBackMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
			init();
		}
		
		private function init():void
		{
			UtliMouseClick.setup(btnBackView, onMouseEventHandler);
		}
		
		private function onMouseEventHandler(value:MovieClip):void
		{
			//
			var _rollP:RollStateProxy = facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy; // 开始滚动状态
			var _rV:RollVo = _rollP.getData() as  RollVo;
			var _psp:PlayStateProxy = facade.retrieveProxy(PlayStateProxy.NAME) as PlayStateProxy;
			var _pVO:PlayStateVo = _psp.getData() as PlayStateVo;
			if (!_rV.isRolling && !_pVO.isfreegamePlay) {
				var s:AddListenerSocket = AddListenerSocket.getInstance();
				s.send("<invoke name='exit_game'/>");
			}
			
		}
		
		override public function handleNotification(notification:INotification):void
		{
		
		}
		
		private function get btnBackView():MovieClip
		{
			return viewComponent as MovieClip;
		}
	
	}

}