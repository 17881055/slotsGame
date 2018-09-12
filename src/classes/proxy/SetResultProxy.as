package classes.proxy
{
	import classes.Main;
	import classes.utli.socket.AddListenerSocket;
	import classes.utli.socket.IAddSocket;
	import flash.external.ExternalInterface;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author ethan
	 */
	public class SetResultProxy extends Proxy implements IAddSocket
	{
		public static const NAME:String = "SetResultProxy";
		//状态
		public static var state:String = '300';
		private var _socket:AddListenerSocket;
		
		public function SetResultProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
			init();
		}
		
		private function init():void
		{
			_socket = AddListenerSocket.getInstance();
			_socket.addProxy(this);
		}
		
		// 赢分,线数,线注,是否JACKPORT 1是 0非 
		public function toGetData(win:String, num:String, bet:String, jackpotState:String = '0'):void
		{
			_socket.send("<invoke name='set_tex_result'><arguments><string>" + AbstractMain.GAME_ID + "</string><string>" + '300' + "</string><string>" + win + "</string><string>" + num + "</string><string>" + bet + "</string><string>" + jackpotState + "</string></arguments></invoke>");
		}
		
		public function socketData(e:XML):void
		{
		
		}
		
	}

}