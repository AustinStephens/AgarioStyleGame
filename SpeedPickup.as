package  {
	
	import flash.display.MovieClip;
	
	
	public class SpeedPickup extends MovieClip {
		/** *Red/blue */
		public var state: ColorState;
		/** *Represents whether or not the pickup has been collided with */
		public var isDead: Boolean = false;
		/** *The radius of the pickup */
		public var radius: Number = 19.5;
		
		/** *Constructor */
		public function SpeedPickup(s: ColorState) {
			state = s;
		}
		
		/** *Method called when it is collided with */
		public function collide(p: Player)
		{
			if(p.colorState == state)
				p.speed += 2 * p.multiplier;
			else
				p.speed -= 1;
			isDead = true;
			
		}
		
		/** *Method called in the update loop */
		public function update(p: Player): void
		{
			
		}
	}
	
}
