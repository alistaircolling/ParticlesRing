package utils{	public class Helper	{		/**	 	* This method accepts two	 	* Point objects and returns	 	* the angle between them	 	* in radians.	 	*/			//can return value in radians or the angle		public static function findAngle(point1:Point, point2:Point, radians:Boolean = true):Number		{			var dx:Number = point2.x - point1.x;			var dy:Number = point2.y - point1.y;			var retN:Number = -Math.atan2(dx,dy);			if (!radians)			{				retN = convRadiansToDegrees(retN);			}			return retN;		}		public static function convRadiansToDegrees(n:Number):Number		{			return n*180/Math.PI;		}		public static function convDegreesToRadians(n:Number):Number		{			return n*Math.PI/180;		}					}}