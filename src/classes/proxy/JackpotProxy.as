package classes.proxy 
{
	import classes.Main;
	import classes.proxy.vo.JackpotVo;
	import classes.utli.socket.AddListenerSocket;
	import classes.utli.socket.IAddSocket;
	import org.puremvc.as3.patterns.proxy.Proxy;
	/**
	 * ...
	 * @author Ethan
	 */
	public class JackpotProxy extends Proxy implements IAddSocket
	{
		public static const NAME:String = "JackpotProxy";
		
		static public const GIVE_JACKPOT_DATA:String = "giveJackpotData";
		private var _socket:AddListenerSocket;
		public function JackpotProxy(proxyName:String = null, data:Object = null) 
		{
			super(proxyName, data);
			init();
		}
		
		private function init():void 
		{
			_socket = AddListenerSocket.getInstance();
			_socket.addProxy(this);
		}
		
		public function toGetData():void
		{
			_socket.send("<invoke name='get_bonus'><arguments><string>" + AbstractMain.GAME_ID + "</string></arguments></invoke>");
		}
		
		public function socketData(e:XML):void
		{
			var _xml:XML = e;
			if (_xml.@name == "get_bonus")
			{
				onCompletes(_xml.arguments.string[0],_xml.arguments.string[1],_xml.arguments.string[2]);
			}
		}
		
		private function onCompletes(param1:String, param2:String, param3:String):void
		{
			var _jV:JackpotVo = new JackpotVo();
			_jV.bigNum = param2;
			_jV.middleNum = param3;
			_jV.smallNum = param1;
			sendNotification(GIVE_JACKPOT_DATA,_jV)
		
		}
		
	}

}