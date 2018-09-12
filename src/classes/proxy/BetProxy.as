package classes.proxy
{
	import classes.proxy.vo.BetVo;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BetProxy extends Proxy
	{
		public static const NAME:String = "BetProxy";
		public function BetProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
		}
	}
}