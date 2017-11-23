package  {
	import flash.display.MovieClip;
	
	public class RedState implements ColorState{
		/** *The frame on all MovieClips in the game (that have a state) that are red */
		private const FRAME: int = 2;
		
		/** *Getter method for the frame variable */
		public function getFrame(): int
		{
			return FRAME;
		}
		
		/** *Changes states to blue */
		public function switchStates(player: MovieClip): void
		{
			player.colorState = player.blueState;
			player.gotoAndStop(1);
		}
	}
	
}
