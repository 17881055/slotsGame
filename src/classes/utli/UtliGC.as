package classes.utli 
{
	import flash.net.LocalConnection;
	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliGC 
	{
		
		public function UtliGC() 
		{
			
		}
		
		static public function todo():void
		{
			try
			{
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			}
			catch (e:*)
			{
			}
		
		}
		
	}

}