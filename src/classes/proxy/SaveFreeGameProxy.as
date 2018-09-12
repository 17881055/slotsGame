package classes.proxy
{
	import classes.utli.socket.AddListenerSocket;
	import classes.utli.socket.IAddSocket;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class SaveFreeGameProxy extends Proxy implements IAddSocket
	{
		public static const NAME:String = "SaveFreeGameProxy";
		private var _socket:AddListenerSocket;
		public function SaveFreeGameProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
			init();
		}
		
		private function init():void
		{
			_socket = AddListenerSocket.getInstance();
			_socket.addProxy(this);
		}
		
		// 游戏ID 线数 注码 freegame次数
		public function toGetData(gameID:String, lineNum:String, bet:String, num:String):void
		{
			_socket.send("<invoke name='save_free_game'><arguments><string>" + gameID + "</string><string>" + lineNum + "</string><string>" + bet + "</string><string>" + num + "</string></arguments></invoke>");
		}
		
		public function socketData(e:XML):void
		{
		
		}
	
	}

}