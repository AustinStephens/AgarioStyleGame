package  {
	
	import flash.display.MovieClip;
	import flash.media.SoundTransform;
	
	
	public class Bomb extends MovieClip {
		/** *Red/blue */
		public var state: ColorState;
		/** *Represents whether or not the pickup has been collided with */
		public var isDead: Boolean = false;
		
		/** *Velocity for y, no acceleration */
		var vy: Number = 200;
		/** *Time left until it blows up */
		var timeLeft: Number = 2;
		/** *How often I want the frame to change in seconds */
		const TIME_FLASH: Number = .2; 
		/** *How much time is left before the next frame change */
		var timeLeftOnFlash: Number = .2;  
		
		/** *Audio variables */
		private var boom: BoomSound = new BoomSound();
		
		/** *Constructor */
		public function Bomb(newState: ColorState) {
			state = newState;
		}
		
		/** *Method called in the update loop */
		public function update(player: Player): void
		{
			timeLeft -= Game.deltaTime;
			if (timeLeft <= 0)
				blowUp(player);
			
			timeLeftOnFlash -= Game.deltaTime;
			if (timeLeftOnFlash <= 0)
			{
				timeLeftOnFlash = TIME_FLASH;
				if(currentFrame == 3)
					gotoAndStop(state.getFrame());
				else
					gotoAndStop(3);
				
			}
			
			y += vy * Game.deltaTime;
		}
		
		/** *Method called when it blows up */
		private function blowUp(player: Player): void
		{	
			//check if the player is the same state as them
			// if not, kills player.
			boom.play(0, 0, new SoundTransform(7));
			if (player.colorState != state)
			{
				//game over
				player.isDead = true;
			}
			
			isDead = true;
			delete this;
			
		}
		
		
	}
	
}
