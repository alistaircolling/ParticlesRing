/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2011
 * http://flintparticles.org/
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package
{
	import flash.events.MouseEvent;
	import flash.display.StageScaleMode;
	import graphics.Drawing;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.renderers.BitmapRenderer;

	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;

	[SWF(width='1000', height='800', frameRate='60', backgroundColor='#000000')]

	public class Main extends Sprite
	{
		private var emitter : CatherineWheel;
		private var _circle : Sprite;
		private var _bg : Sprite;
		private var _button : Sprite;
		private var _topCircle : Sprite;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			drawBackground();
		//	createCircle();
			createButton();
			
			emitter = new CatherineWheel();

			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, 0, 1000, 800 ) );
			renderer.addFilter( new BlurFilter( 4, 4, 1 ) );
			renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.97,0 ] ) );
			renderer.addEmitter( emitter );
			addChild( renderer );

			emitter.x = 500;
			emitter.y = 400;
			emitter.start( );
			
			drawTopCircle();
		}

		private function drawTopCircle() : void {
			
			_topCircle = new Sprite();
			_topCircle.graphics.beginFill(0x0,1);
			_topCircle.graphics.lineStyle(1, 0x0066ff,0, true);
			_topCircle.graphics.drawCircle(0,0,ParticleConstants.CIRCLE_RADIUS-3);
			_topCircle.x = 500;
			_topCircle.y = 400;
			
			addChild(_topCircle);
		}

		private function createButton() : void {
			
			_button = new Sprite();
			_button.graphics.beginFill(0xf388ff);
			_button.graphics.lineStyle(1, 0x0, 0);
			_button.graphics.drawRect(0, 0, 80, 30);
			_button.x = 870;
			_button.y = 730;
			addChild(_button);
			_button.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event : MouseEvent) : void {
			emitter.freeParticles();
		}

		private function drawBackground() : void {
			
			_bg = new Sprite();
			_bg.graphics.beginFill(0xff0000, 0);
			_bg.graphics.lineStyle(1, 0x0066ff);
			_bg.graphics.drawRect(0, 0, 1000, 800);
			addChild(_bg);
			
			
		}

		private function createCircle() : void {
			
			
			_circle = new Sprite();
			_circle.graphics.beginFill(0xff000, 0);
			_circle.graphics.lineStyle(1, 0x0066ff,1, true);
			_circle.graphics.drawCircle(0,0,ParticleConstants.CIRCLE_RADIUS);
			_circle.x = 500;
			_circle.y = 400;
			
			addChild(_circle);
			
		}
	}
}