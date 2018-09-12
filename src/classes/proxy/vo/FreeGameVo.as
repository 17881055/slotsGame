package classes.proxy.vo
{
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class FreeGameVo
	{
		private var _gameId:String;
		private var _freeGameNum:int;
		private var _lineNum:uint;
		private var _bet:Number;
		public function FreeGameVo()
		{
		
		}
		
		public function get gameId():String
		{
			return _gameId;
		}
		
		public function set gameId(value:String):void
		{
			_gameId = value;
		}
		
		public function get freeGameNum():int
		{
			return _freeGameNum;
		}
		
		public function set freeGameNum(value:int):void
		{
			_freeGameNum = value;
		}
		
		public function get lineNum():uint
		{
			return _lineNum;
		}
		
		public function set lineNum(value:uint):void
		{
			_lineNum = value;
		}
		
		public function get bet():Number
		{
			return _bet;
		}
		
		public function set bet(value:Number):void
		{
			_bet = value;
		}
	
	}

}