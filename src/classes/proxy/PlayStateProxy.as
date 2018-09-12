package classes.proxy
{
	import classes.proxy.vo.PlayStateVo;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class PlayStateProxy extends Proxy
	{
		public static const NAME:String = "PlayStateProxy";
		
		public function PlayStateProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
			var _pV:PlayStateVo = new PlayStateVo();
			_pV.isAutoPlay = false;
			_pV.isManuallyPlay = false;
			_pV.isfreegamePlay = false;
			_pV.isEnoughBalance = false;
			setData(_pV);
		}
		
		public function toEnoughBalanceState():void {
			var _pV:PlayStateVo = getData() as PlayStateVo;
			_pV.isEnoughBalance = true;
			setData(_pV);
		}
		
		public function toNotEnoughBalanceState():void {
			var _pV:PlayStateVo = getData() as PlayStateVo;
			_pV.isEnoughBalance = false;
			setData(_pV);
		}
		
		public function toFreeGamePlayState():void {
			var _pV:PlayStateVo = getData() as PlayStateVo;
			_pV.isfreegamePlay = true;
			setData(_pV);
		}
		
		public function toStopFreeGamePlayState():void {
			var _pV:PlayStateVo = getData() as PlayStateVo;
			_pV.isfreegamePlay = false;
			setData(_pV);
		}
		
		public function toAutoPlayState():void
		{
			var _pV:PlayStateVo = new PlayStateVo();
			_pV.isAutoPlay = true;
			_pV.isManuallyPlay = false;
			_pV.isfreegamePlay = false;
			setData(_pV);
		}
		
		public function toManuallyPlayState():void
		{
			var _pV:PlayStateVo = new PlayStateVo();
			_pV.isAutoPlay = false;
			_pV.isManuallyPlay = true;
			_pV.isfreegamePlay = false;
			setData(_pV);
		}
		
		public function toStopState():void
		{
			var _pV:PlayStateVo = new PlayStateVo();
			_pV.isAutoPlay = false;
			_pV.isManuallyPlay = false;
			_pV.isfreegamePlay = false;
			setData(_pV);
		}
	
	}

}