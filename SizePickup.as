package  {
	
	import flash.display.MovieClip;
	
	
	public class SizePickup extends MovieClip {
		
		/** *Red/blue */
		public var state: ColorState;
		/** *The radius of the pickup */
		public var radius: Number = 22;
		/** *Represents whether or not the pickup has been collided with */
		public var isDead: Boolean = false;
		
		/** *Constructor */
		public function SizePickup(s: ColorState) {
			state = s;
		}
		
		/** *Method called when it is collided with */
		public function collide(p: Player)
		{
			if(p.colorState == state)
				p.size += 1 * p.multiplier;
			else
				p.size -= 1;
			
			isDead = true;
			
		}
		
		/** *Method called in the update loop */
		public function update(p: Player): void
		{
			
		}
	}
	
}
