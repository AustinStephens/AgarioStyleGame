package  {
	
	import flash.display.MovieClip;
	
	
	public class Spinner extends MovieClip {
		/** *The radius of the pickup */
		public var radius: Number = 50;
		/** *The speed of rotation */
		var rotationSpeed: Number = 45;
		/** *Represents whether or not the pickup has been collided with */
		var isDead: Boolean = false;
		
		/** *Constructor */
		public function Spinner() {
			// constructor code
		}
		
		/** *Method called in the update loop */
		public function update(p: Player)
		{
			rotation += rotationSpeed * Game.deltaTime;
		}
		
		/** *Method called when it is collided with */
		public function collide(p: Player)
		{
			//kill player end game
			p.isDead = true;
		}
		
	}
	
}
