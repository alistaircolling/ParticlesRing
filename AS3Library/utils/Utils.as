package utils {
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class Utils {
		public static function ranRange(minNum : Number, maxNum : Number) : Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}

		public static function getURL(url : String, window : String = null) : void {
			var req : URLRequest = new URLRequest(url);
			trace("getURL", url);
			try {
				navigateToURL(req, window);
			} catch (e : Error) {
				trace("Navigate to URL failed", e.message);
			}
		}

		public static function makeButton(m : MovieClip) : void {
			m.buttonMode = true;
			m.useHandCursor = true;
			m.mouseChildren = false;
		}
	}
}