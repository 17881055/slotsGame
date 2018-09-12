package classes.proxy.vo
{
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class BalanceVo
	{
		private var _balance:Number;
		
		public function get balance():Number
		{
			//trace("return_BalanceVo " + _balance);
			return _balance;
		}
		
		public function set balance(value:Number):void
		{
			_balance = value;
			//trace("BalanceVo " + _balance);
		}
	
	}

}