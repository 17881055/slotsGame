package classes.proxy
{
	import classes.Main;
	import classes.mediator.bottomBar.displayView.DisplayBalanceMediator;
	import classes.proxy.vo.FreeGameVo;
	import classes.utli.socket.AddListenerSocket;
	import classes.utli.socket.IAddSocket;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Ethan
	 */
	public class FreeGameProxy extends Proxy implements IAddSocket
	{
		public static const NAME:String = "FreeGameProxy";
		public static const GIVE_FREEGAME_DATA:String = "give_freeGame_data";
		private var _socket:AddListenerSocket;
		public function FreeGameProxy(proxyName:String = null, data:Object = null)
		{
			super(proxyName, data);
			init();
		}
		
		private function init():void
		{
			var _fg:FreeGameVo = new FreeGameVo();
			_fg.freeGameNum = 0;
			_fg.gameId = null;
			setData(_fg);
			_socket = AddListenerSocket.getInstance();
			_socket.addProxy(this);
		}
		
		public function toGetData(gameID:String):void
		{
			_socket.send("<invoke name='load_free_game'><arguments><string>" + gameID + "</string></arguments></invoke>");
		}
		
		public function socketData(e:XML):void
		{
			var _xml:XML = e;
			
			if (_xml.@name == "load_free_game")
			{
				onCompletes(_xml.arguments.string[0],_xml.arguments.string[1],_xml.arguments.string[2],_xml.arguments.string[3]);
			}
		}
		
		//游戏ID
		//线数
		//注码
		//freegame次数
		private function onCompletes(gameID:String, lineNum:String, bet:String, num:String):void
		{
			if (gameID=="failed") {
				sendNotification(DisplayBalanceMediator.REQUEST_BALANCE_DATA_COMMAND);
				sendNotification(DisplayBalanceMediator.START_TIMER);
				return;
			}
			if (gameID == AbstractMain.GAME_ID && int(num) > 0)
			{
				var _fg:FreeGameVo = new FreeGameVo();
				_fg.freeGameNum = int(num);
				_fg.gameId = gameID;
				_fg.lineNum = int(lineNum);
				_fg.bet = Number(bet);
				setData(_fg);
				
				sendNotification(GIVE_FREEGAME_DATA, _fg);
				sendNotification(DisplayBalanceMediator.START_TIMER);
			}
			else
			{
				sendNotification(DisplayBalanceMediator.REQUEST_BALANCE_DATA_COMMAND);
				sendNotification(DisplayBalanceMediator.START_TIMER);

			}
		
		}
	
	}

}