package classes.proxy
{
	import classes.Main;
	import classes.proxy.vo.ResultVo;
	import classes.utli.socket.AddListenerSocket;
	import classes.utli.socket.IAddSocket;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class ResultProxy extends Proxy implements IAddSocket
	{
		public static const NAME:String = "ResultProxy";
		static public const GIVE_RESULT_DATA:String = "giveResultData";
		private var _socket:AddListenerSocket;
		
		public function ResultProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
			init();
		}
		
		private function init():void
		{
			_socket = AddListenerSocket.getInstance();
			_socket.addProxy(this);
		}
		
		public function toGetData(id:String, state:String, bet:String, num:String):void
		{
			_socket.send("<invoke name='get_tex_result'><arguments><string>" + id + "</string><string>" + state + "</string><string>" + bet + "</string><string>" + num + "</string><string>" + AbstractMain.GAME_ID + "</string></arguments></invoke>");
		}
		
		public function socketData(e:XML):void
		{
			var _xml:XML = e;
			if (_xml.@name == "get_tex_result")
			{
				onCompletes(_xml.arguments.string[0], _xml.arguments.string[1], _xml.arguments.string[2], _xml.arguments.string[3], _xml.arguments.string[4]);
			}
		}
		
		//0:随机ID; 1:WIN 数值; 2:停位置; 3:中奖线条数; 4:freeGame次数;
		public function onCompletes(param0:String, param1:String, param2:String, param3:String, param4:String):void
		{
			var _rV:ResultVo = new ResultVo();
			_rV.romandID = uint(param0);
			_rV.win = Number(param1);
			var _sp:Array = param2.split(',');
			_rV.stopPosition = Vector.<String>(_sp);
			if (param3)
			{
				var _ls:Array = param3.split(',');
				_rV.liners = Vector.<String>(_ls);
			}
			
			var _fGNs:Array = param4.split(',');
			_rV.freeGameNum = uint(_fGNs[0]);
			sendNotification(GIVE_RESULT_DATA, _rV);
		}
	
	}

}