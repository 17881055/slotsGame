package classes.utli.socket
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AddListenerSocket
	{
		
		public var socket:Socket;
		private static var _instance:AddListenerSocket;
		public var callBackFunction:Function;
		public var target:Proxy;
		public var proxys:Vector.<IAddSocket>;
		private var buf_left:uint; //atuxp_start
		private var cmd_str:String; //atuxp_end
		
		public function AddListenerSocket()
		{
			init();
		}
		
		public static function getInstance():AddListenerSocket
		{
			if (_instance == null)
			{
				_instance = new AddListenerSocket();
			}
			return _instance;
		}
		
		public function init():void
		{
			socket = new Socket();
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataFun);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandlerA);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandlerB);
			socket.addEventListener(Event.CLOSE, closeFun);
			socket.connect("127.0.0.1", 60590);
			proxys = new Vector.<IAddSocket>();
		
		}
		
		private function onErrorHandlerA(e:IOErrorEvent):void
		{
			socket.connect("127.0.0.1", 60590);
		}
		
		private function onErrorHandlerB(e:SecurityErrorEvent):void
		{
			socket.connect("127.0.0.1", 60590);
		}
		
		public function addProxy(value:IAddSocket):void
		{
			var _o:Boolean = false;
			for (var i:int = 0; i < proxys.length; i++)
			{
				if (value == proxys[i])
				{
					_o = true;
				}
			}
			if (!_o)
			{
				proxys.push(value);
			}
		
		}
		
		public function send(value:String):void
		{
			writeln(value);
			socket.flush();
		}
		
		public function writeln(str:String):void
		{
			try
			{
				socket.writeShort(str.length);
				socket.writeUTFBytes(str);
			}
			catch (e:IOError)
			{
			}
		}
		
		public function closeFun(e:Event):void
		{
		
		}
		
		//atuxp_start
		private function cmdFun(cmd:String):void
		{
			var str:String = cmd;
			var _xml:XML = new XML(str);
			for (var i:int = 0; i < proxys.length; i++)
			{
				proxys[i].socketData(_xml);
			}
		}
		
		private function getData():void
		{
			//atuxp_start
			var t_str:String;
			if (buf_left > 0)
			{
				if (socket.bytesAvailable < buf_left)
					return;
				
				t_str = socket.readUTFBytes(buf_left);
				cmd_str += t_str;
				cmdFun(cmd_str);
				cmd_str = "";
				buf_left = 0;
			}
			
			while (socket.bytesAvailable > 2)
			{
				var cmd_len:uint = socket.readUnsignedShort();
				
				if (socket.bytesAvailable >= cmd_len)
				{
					cmd_str = socket.readUTFBytes(cmd_len);
					cmdFun(cmd_str);
					cmd_str = "";
				}
				else
				{
					var avai:uint = socket.bytesAvailable;
					cmd_str = socket.readUTFBytes(avai);
					buf_left = cmd_len - avai;
					break;
				}
				
			}
		}
		
		public function socketDataFun(e:ProgressEvent):void
		{
			getData();
		
		}
		
		public function onConnect(e:Event):void
		{
		
		}
	
	}

}