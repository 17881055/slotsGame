package classes.utli 
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Ethan
	 */
	public class UtliColorTransformer 
	{
		
		public function UtliColorTransformer() 
		{
			
		}
		
		//变颜色
		static public function colorTransformer(obj:MovieClip, value:Number=1):void
		{
			
			var _ct:ColorTransform = obj.transform.colorTransform;
			_ct.blueMultiplier = value;
			_ct.redMultiplier = value;
			_ct.greenMultiplier = value;
			_ct.redOffset = 0;
			_ct.greenOffset = 0;
			_ct.blueOffset = 0;
			obj.transform.colorTransform = _ct;
		
		
		}
		
	}

}