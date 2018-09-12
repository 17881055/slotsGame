package classes.proxy
{
	import classes.proxy.vo.BalanceVo;
	import classes.proxy.vo.RollVo;
	import classes.utli.socket.AddListenerSocket;
	import classes.utli.socket.IAddSocket;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BalanceProxy extends Proxy implements IAddSocket
	{
		public static const NAME:String = "BalanceProxy";
		public static const GIVE_BALANCE_DATA:String = "give_balance_data";
		static public const GIVE_FRIST_BALANCE_DATA:String = "give_frist_balance_data";
		private var _socket:AddListenerSocket;
		private var _frist:Boolean=false;
		
		public function BalanceProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
			init();
		}
		
		private function init():void
		{
			var _bV:BalanceVo = new BalanceVo();
			_bV.balance = 0;
			setData(_bV);
			_socket = AddListenerSocket.getInstance();
			_socket.addProxy(this);
		}
		
		public function toGetData(isFirst:Boolean = false):void
		{
			_socket.send("<invoke name='get_credit'/>");
			_frist = isFirst;
		}
		
		public function socketData(e:XML):void
		{
			var _xml:XML = e;
			if (_xml.@name == "get_credit")
			{
				onCompletes(_xml.arguments.string);
			}
		}
		
		private function onCompletes(param1:String):void
		{
			var _rollP:RollStateProxy = facade.retrieveProxy(RollStateProxy.NAME) as RollStateProxy;
			var _rV:RollVo = _rollP.getData() as RollVo;
			if (!_rV.isRolling) {
				var _bV:BalanceVo = new BalanceVo();
				_bV.balance = Number(param1);
				setData(_bV);
			}
			
			if (_frist) {
				sendNotification(GIVE_FRIST_BALANCE_DATA, _bV);
			}
			else
			{
				sendNotification(GIVE_BALANCE_DATA, _bV);
			}
		
		}
	}
}