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

package {
	import org.flintparticles.twoD.particles.Particle2D;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.Explosion;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flintparticles.common.counters.TimePeriod;
	import org.flintparticles.twoD.zones.RectangleZone;
	import org.flintparticles.twoD.zones.DiscSectorZone;
	import org.flintparticles.twoD.actions.CollisionZone;
	import org.flintparticles.twoD.zones.DiscZone;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.displayObjects.Line;
	import org.flintparticles.common.initializers.ColorInit;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.twoD.actions.Accelerate;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.activities.RotateEmitter;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Velocity;

	import flash.geom.Point;

	public class CatherineWheel extends Emitter2D
	{
		private var _collisionZone : CollisionZone;
		private var _innerCollisionZone : CollisionZone;
		private var _timer : Timer;
		
		
		
		public function CatherineWheel()
		{
			//counter = new Steady( 200 );
			//counter = new TimePeriod(100, 1);
			counter = new Steady(50);
			addActivity( new RotateEmitter( 7 ) );
			
			addInitializer( new SharedImage( new Line( 3 ) ) );
			addInitializer( new ColorInit( 0xff00ccff, 0xff78b1ff ) );
			//addInitializer( new Lifetime( 1.3 ) );
			addInitializer( new Velocity( new DiscZone( new Point( 0, 0 ), 600, 500)));//, 0, 0.2 ) ) );
			_collisionZone = new CollisionZone(new DiscZone(new Point(500,400), ParticleConstants.CIRCLE_RADIUS+50, ParticleConstants.CIRCLE_RADIUS), -.4); 
			_innerCollisionZone = new CollisionZone(new DiscZone(new Point(500,400), ParticleConstants.CIRCLE_RADIUS-20, ParticleConstants.CIRCLE_RADIUS-25), 1); 
			addAction(_collisionZone);
			
			//addAction(_innerCollisionZone);
			
		//	addAction( new Age( Quadratic.easeIn ) );
			addAction( new Move() );
		//	addAction( new Fade() );
			addAction( new Accelerate( 0, 0) );
	//		addAction( new LinearDrag( 0.5 ) );
			_timer = new Timer(100, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			//_timer.start();
			
		}

		private function onTimerComplete(event : TimerEvent) : void {
			trace("CatherineWheel.onTimerComplete(event)  ");
		//	removeAction(_collisionZone);
			addAction(_collisionZone);
			_timer.stop();
		}

		public function freeParticles() : void {
			trace("free particles");
			removeAction(_collisionZone);
			//removeVelocityFromParticles();
			makeAllParticlesRepel();
			addAction( new Explosion(10, 500, 500));
			//only for a short time!
			_timer.start();
			//now remove the collision radius
			
			
		}

		private function makeAllParticlesRepel() : void {
			for (var i : int = 0; i < particlesArray.length; i++) {
				var parti:Particle2D = particlesArray[i] as Particle2D;
				parti.collisionRadius = 20;
				
			}
		}

		private function removeVelocityFromParticles() : void {
			for (var i : int = 0; i < particlesArray.length; i++) {
				var parti:Particle2D = particlesArray[i] as Particle2D;
				parti.velX = 0
				parti.velY = 0;
				
			}
		}
	}
}