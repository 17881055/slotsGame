package classes.proxy.vo
{
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class JackpotVo
	{
		private var _smallNum:String;
		private var _bigNum:String;
		private var _middleNum:String;
		
		public function get smallNum():String
		{
			return _smallNum;
		}
		
		public function set smallNum(value:String):void
		{
			_smallNum = value;
		}
		
		public function get bigNum():String
		{
			return _bigNum;
		}
		
		public function set bigNum(value:String):void
		{
			_bigNum = value;
		}
		
		public function get middleNum():String
		{
			return _middleNum;
		}
		
		public function set middleNum(value:String):void
		{
			_middleNum = value;
		}
	
	}

}