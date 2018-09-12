package classes.proxy.vo
{
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class ResultVo
	{
		private var _isWin:Boolean;
		private var _romandID:uint;
		private var _win:Number;
		private var _stopPosition:Vector.<String>;
		private var _liners:Vector.<String>;
		private var _freeGameNum:uint;
		
		public function ResultVo()
		{
			_stopPosition = new Vector.<String>;
			_liners = new Vector.<String>;
		}
		
		public function get romandID():uint
		{
			return _romandID;
		}
		
		public function set romandID(value:uint):void
		{
			_romandID = value;
		}
		
		public function get win():Number
		{
			return _win;
		}
		
		public function set win(value:Number):void
		{
			_win = value;
		}
		
		public function get stopPosition():Vector.<String>
		{
			return _stopPosition;
		}
		
		public function set stopPosition(value:Vector.<String>):void
		{
			_stopPosition = value;
		}
		
		public function get liners():Vector.<String>
		{
			return _liners;
		}
		
		public function set liners(value:Vector.<String>):void
		{
			_liners = value;
			if (value.length != 0 && value[0] != '0')
			{
				_isWin = true;
			}
			else
			{
				_isWin = false;
			}
		}
		
		public function get freeGameNum():uint
		{
			return _freeGameNum;
		}
		
		public function set freeGameNum(value:uint):void
		{
			_freeGameNum = value;
		}
		
		public function get isWin():Boolean
		{
			return _isWin;
		}
	
	}

}