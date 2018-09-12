package classes.proxy.vo 
{
	/**
	 * ...
	 * @author Ethan
	 */
	public class PlayStateVo 
	{
		private var _isAutoPlay:Boolean;
		private var _isManuallyPlay:Boolean;
		private var _isfreegamePlay:Boolean;
		private var _isEnoughBalance:Boolean;
		
		
		public function PlayStateVo() 
		{
			
		}
		
		public function get isAutoPlay():Boolean 
		{
			return _isAutoPlay;
		}
		
		public function set isAutoPlay(value:Boolean):void 
		{
			_isAutoPlay = value;
		}
		
		public function get isManuallyPlay():Boolean 
		{
			return _isManuallyPlay;
		}
		
		public function set isManuallyPlay(value:Boolean):void 
		{
			_isManuallyPlay = value;
		}
		
		public function get isfreegamePlay():Boolean 
		{
			return _isfreegamePlay;
		}
		
		public function set isfreegamePlay(value:Boolean):void 
		{
			_isfreegamePlay = value;
		}
		
		public function get isEnoughBalance():Boolean 
		{
			return _isEnoughBalance;
		}
		
		public function set isEnoughBalance(value:Boolean):void 
		{
			_isEnoughBalance = value;
		}
		
		
		
	}

}