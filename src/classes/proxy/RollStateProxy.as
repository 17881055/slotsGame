package classes.proxy 
{
	import classes.proxy.vo.RollVo;
	import org.puremvc.as3.patterns.proxy.Proxy;
	/**
	 * ...
	 * @author Ethan
	 */
	public class RollStateProxy extends Proxy
	{
		public static const NAME:String = "RollStateProxy";
		public function RollStateProxy(proxyName:String = null, data:Object = null) 
		{
			super(proxyName, data);
			init();
		}
		
		private function init():void 
		{
			var _rV:RollVo = new RollVo();
			_rV.isRolling = false;
			this.setData(_rV);
		}
		
	}

}