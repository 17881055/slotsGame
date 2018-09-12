package classes.utli
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;


	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliSoundManage
	{
		private static var _instance:UtliSoundManage;

		private var _addSound:Sound;
		private var _subSound:Sound;
		private var _autoPlaySound:Sound;
		private var _startRollSound:Sound;
		private var _stopRollSound:Sound;
		private var _hasFreeSpinSound:Sound;
		private var _welcomeSound:Sound;
		private var _winSound:Sound;
		private var _freeGameStartRollSound:Sound;
		private var _freeGameWinSound:Sound;
		private var _freeGameInSonud:Sound;
		private var _jackpotSound:Sound;

		public function UtliSoundManage(singletoner:Singletoner)
		{
			init();
		}

		private function init():void
		{
			_addSound=new AddSound();
			_subSound=new SubSound();
			_autoPlaySound=new AutoPlaySound();
			_startRollSound=new StartRollSound();
			_stopRollSound=new StopRollSound();
			_hasFreeSpinSound=new HasFreeSpinSound();
			_welcomeSound=new WelcomeSound();
			_winSound=new WinSound();
			_freeGameWinSound=new FreeGameWinSound();
			_freeGameInSonud=new FreeGameInSound();
			_freeGameStartRollSound=new FreeGameStartRollSound();
			_jackpotSound=new JackpotSound();
		}

		public static function getInstance():UtliSoundManage
		{
			if (_instance == null)
			{
				_instance=new UtliSoundManage(new Singletoner());
			}
			return _instance;
		}

		public function isSoundOver(target:Sound, soundChannel:SoundChannel, over:Function):void
		{
			if (soundChannel.position != 0 && soundChannel.position < target.length - 1)
			{
				soundChannel.addEventListener(Event.SOUND_COMPLETE, overHandler);
				function overHandler(e:Event):void
				{
					over();
					soundChannel.removeEventListener(Event.SOUND_COMPLETE, overHandler);
				}
			}
			else
			{
				over();
			}
		}

		public function get addSound():Sound
		{
			return _addSound;
		}

		public function get subSound():Sound
		{
			return _subSound;
		}

		public function get autoPlaySound():Sound
		{
			return _autoPlaySound;
		}

		public function get startRollSound():Sound
		{
			return _startRollSound;
		}

		public function get stopRollSound():Sound
		{
			return _stopRollSound;
		}

		public function get hasFreeSpinSound():Sound
		{
			return _hasFreeSpinSound;
		}

		public function get welcomeSound():Sound
		{
			return _welcomeSound;
		}

		public function get winSound():Sound
		{
			return _winSound;
		}

		public function get freeGameStartRollSound():Sound
		{
			return _freeGameStartRollSound;
		}

		public function get freeGameWinSound():Sound
		{
			return _freeGameWinSound;
		}

		public function get freeGameInSonud():Sound
		{
			return _freeGameInSonud;
		}

		public function get jackpotSound():Sound
		{
			return _jackpotSound;
		}

	}

}

internal class Singletoner
{
}
