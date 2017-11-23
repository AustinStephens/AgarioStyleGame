package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Player extends MovieClip {
		
		/** *Constant representing the size of the circle at the beginning of the game. */
		private const ORIGINAL_SIZE: Number = 138.5;
		/** *Points accumulated by the player */
		public var points: Number;
		/** *Size of the Player */
		public var size: Number = ORIGINAL_SIZE;
		/** *Represents whether or not the pickup has been collided with */
		public var isDead: Boolean = false;
		
		/** *variables for the states, avoids memeory leaks */
		public var blueState = new BlueState();
		public var redState = new RedState();
		public var colorState: ColorState = blueState;
		
		/** *The speed of the player */
		public var speed: Number = 150;
		/** *The multiplier on the points, increased by PentPickups */
		public var multiplier: Number = 1;
		/** *The time left on the multiplier */
		public var multCounter: Number = 0;
		
		/** *Constructor */
		public function Player()
		{

			gotoAndStop(1);
			  // trying to encapsulate code but this only works when the circle is clicked
		}
		
		/** *Method called in the update loop */
		public function update(): void
		{
			var dy: Number= parent.mouseY - y;
			var dx: Number = parent.mouseX - x;
			
			if (Math.abs(dy) > 5 || Math.abs(dx) > 5) // stops the player for shaking when the mouse is at the center of the player.
			{
				var angleInRads: Number = Math.atan2(dy, dx);
				x += Math.cos(angleInRads) * speed * Game.deltaTime;
				y += Math.sin(angleInRads) * speed * Game.deltaTime;
			}
			
			
			points = (size - ORIGINAL_SIZE) * 100;
			width = size;
			height = size;
			
			multCounter -= Game.deltaTime;
			if(multCounter > 0)
				multiplier = 2;
			else
			{
				multiplier = 1;
				multCounter = 0;
			}
		}
		
		/** 
		 * Changes states (red to blue or blue to red)
		 * @param  e  The mouse event
		 */
		public function switchStates(e: MouseEvent):void
		{
			colorState.switchStates(this);
		}
		
		/** *Called when the game is restarted */
		public function restart(): void
		{
			size = ORIGINAL_SIZE;
			x = 400;
			y = 400;
			width = ORIGINAL_SIZE;
			height = ORIGINAL_SIZE;
			isDead = false;
			points = 0;
			visible = true;
		}
	}
	
}
