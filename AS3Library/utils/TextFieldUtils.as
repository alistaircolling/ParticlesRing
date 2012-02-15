package utils{
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author acolling
	 */
	public class TextFieldUtils {
		
		
		public static function createTextField(multi:Boolean , selectable:Boolean = false, width:uint = 100, height:uint = 50 ) : TextField {
			var textField : TextField = new TextField();
			textField.selectable = selectable;
			textField.embedFonts = true;
			textField.wordWrap = multi;
			textField.multiline = multi;
			textField.mouseWheelEnabled = false;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.width = width;
			textField.height = height;
			
			return textField;
		}
		
		
		public static function createTextFormat(fontName : String, fontColor : Number, fontSize : uint, letterSpacing : int = 0, bold:Boolean = false) : TextFormat {
			var textFormat : TextFormat = new TextFormat;
			textFormat.font = fontName;
			textFormat.color = fontColor;
			textFormat.letterSpacing = letterSpacing;
			textFormat.bold = bold;
			textFormat.size = fontSize;
			return textFormat;
		};

		
		
	}
}
