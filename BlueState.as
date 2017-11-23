package  {
	import flash.display.MovieClip;
	
	public class BlueState implements ColorState{
		/** *The frame on all MovieClips in the game (that have a state) that are blue */
		private const FRAME: int = 1;
		
		/** *Getter method for the frame variable */
		public function getFrame(): int
		{
			return FRAME;
		}
		
		/** *Changes states to red */
		public function switchStates(player: MovieClip): void
		{
			player.colorState = player.redState;
			player.gotoAndStop(2);
		}

	}
	
}
