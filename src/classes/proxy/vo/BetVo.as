package classes.proxy.vo
{

	/**
	 * ...
	 * @author Ethan
	 */
	public class BetVo
	{
		private var _betRate:Number;
		private var _lineNum:uint;
		private var _bet:Number;

		public function get betRate():Number
		{
			return _betRate;
		}

		public function set betRate(value:Number):void
		{
			_betRate=value;
		}

		public function get lineNum():uint
		{
			return _lineNum;
		}

		/**
		 * 多少号线
		 * @param value
		 *
		 */
		public function set lineNum(value:uint):void
		{
			_lineNum=value;
		}

		public function get bet():Number
		{
			return _bet;
		}

		public function set bet(value:Number):void
		{
			_bet=value;
		}

	}

}
