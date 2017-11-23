package  {
	import flash.display.MovieClip;
	
	public interface ColorState {
		
		function getFrame(): int;

		function switchStates(player: MovieClip): void;

	}
	
}
