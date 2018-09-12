package classes.proxy.vo
{

	/**
	 * @author Ethan
	 * @E-mail: 17881055@qq.com
	 * 创建时间：2014-8-25 下午11:11:22
	 * lineVo.as
	 */
	public class lineVo
	{
		private var _lineNum:uint;
		private var _isShow:Boolean;

		public function get isShow():Boolean
		{
			return _isShow;
		}

		/**
		 * 是否显示
		 * @param value
		 *
		 */
		public function set isShow(value:Boolean):void
		{
			_isShow=value;
		}

		/**
		 * 线号码
		 * @return
		 *
		 */
		public function get lineNum():uint
		{
			return _lineNum;
		}

		public function set lineNum(value:uint):void
		{
			_lineNum=value;
		}

	}
}
