package  {
	
	import flash.display.MovieClip;
	
	
	public class Pent extends MovieClip {
		
		/** *Represents whether or not the pickup has been collided with */
		public var isDead: Boolean = false;
		/** *The radius of the pickup */
		public var radius: Number = 23;
		
		/** *Constructor */
		public function Pent() {
		}
		
		/** *Method called when it is collided with */
		public function collide(p: Player): void
		{
			p.multCounter = 5;
			isDead = true;
		}
		
		/** *Method called in the update loop */
		public function update(p: Player): void
		{
			
		}
	}
	
}
