package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	
	public class Game extends MovieClip {
		
		//// COLLISION GROUPS ////////////////////////
		// player v size, player v speed, player v spinner, player v pent //
		
		/** * If the game is running or on the game over screen */
		public var isRunning: Boolean = true;
		/** *Change in time */
		public static var deltaTime: Number;
		/** *Use to determine deltaTime */
		private var previousTime: int = 0;
		/** *Array of all the different pickup collections */
		private var arrays: Array = new Array();
		/** *Pickup collections */
		private var bombs: Array = new Array();
		private var sizePickups: Array = new Array();
		private var speedPickups: Array = new Array();
		private var pentPickups: Array = new Array();
		private var spinners: Array = new Array();
		
		/** *Counter used to time when bombs are spawned */
		private var counter: Number = .5;
		
		/** *Audio variables */
		private var channel: SoundChannel = new SoundChannel();
		private var boop: BoopSound = new BoopSound();
		private var death: DeathSound = new DeathSound();
		private var music: Music = new Music();
		
		/** *Constructor */
		public function Game() {
			channel = new SoundChannel();
			channel = music.play(0, 10, new SoundTransform(.5));
			addEventListener(Event.ENTER_FRAME, gameLoop);
			resetScene();
			arrays = [bombs, sizePickups, speedPickups, pentPickups, spinners];
			setChildIndex(scoreText, 1);
			setChildIndex(player, 0);
		}
		
		/** *Sets deltaTime */
		public function getDeltaTime(): void
		{
			var currentTime: int = getTimer();
			deltaTime = (currentTime - previousTime) / 1000;
			previousTime = currentTime;
		}
		
		/** *Spawn pickup methods *////////////////////////////////////////////////////////////
		private function spawnSize(num: int): void
		{
			for (var i: int = 0; i < num; i++)
			{
				var object: SizePickup = new SizePickup(randState());
				object.gotoAndStop(object.state.getFrame());
				sizePickups.push(object);
				addToScene(object);
			}
		}
		
		private function spawnSpeed(num: int): void
		{
			for (var i: int = 0; i < num; i++)
			{
				var object: SpeedPickup = new SpeedPickup(randState());
				object.gotoAndStop(object.state.getFrame());
				speedPickups.push(object);
				addToScene(object);
			}
		}
		
		private function spawnBomb(): void
		{
			var object: Bomb = new Bomb(randState());
			object.gotoAndStop(object.state.getFrame());
			bombs.push(object);
			addChild(object);
			object.x = Math.random() * 800;
			object.y = 0;
		}
		
		private function spawnPent(num: Number): void
		{
			for (var i: int = 0; i < num; i++)
			{
				var object: Pent = new Pent();
				pentPickups.push(object);
				addToScene(object);
			}
		}
		
		private function spawnSpinner(num: Number): void
		{
			for (var i: int = 0; i < num; i++)
			{
				var object: Spinner = new Spinner();
				spinners.push(object);
				addToScene(object);
			}
		}
		
		/** 
		 * Adds the child to the scene, randomizes the position 
		 * @param  object  The object added to the scene
		 */
		private function addToScene(object: MovieClip): void
		{
			addChildAt(object, 0);
			object.x = Math.random() * 800;
			object.y = Math.random() * 800;
		}
		
		/** *Sets a random red/blue state to a new object */
		private function randState(): ColorState
		{
			if (Math.floor(Math.random() * 2) == 1)
				return player.redState;
			else
				return player.blueState;
		}
		
		/** 
		 * Game loop 
		 * @param  e  The enter frame event
		 */
		private function gameLoop(e: Event): void
		{
			///// COUNTERS ///////////////
			getDeltaTime();
			
			if(!isRunning) return;
			
			counter -= deltaTime;
			if (counter <= 0)
			{
				counter = 4;
				spawnBomb();
			}
			////// END COUNTERS ////////
			////// UPDATES /////////////
			scoreText.text = "Score: " + player.points;
			player.update();
			
			
			// Not most efficient, but still seperates the different objects
			// Made a more efficient version in Kitchen Roller - gameScene.
			for(var j: int = 0; j < arrays.length; j++)
			{
				for(var k: int = arrays[j].length - 1; k >= 0; k--)
				{
					arrays[j][k].update(player);
					if(arrays[j][k].isDead)
					{
						removeChild(arrays[j][k]);
						arrays[j].removeAt(k);
					}
				}
			}
			////// END UPDATES ////////
			////// COLLISIONS /////////////
			checkCollisions();
			
			if(player.points > 20000)
				gameWon();
			else if(player.isDead)
			{
				death.play();
				gameWon();
			}
		}
		
		/** *Called when the game is over, win or lose */
		private function gameWon(): void
		{
			player.visible = false;
			gameOver.visible = true;
			restartText.visible = true;
			gameOver.text = (player.isDead ? "Game Over" : "You Won");
			isRunning = false;
			stage.removeEventListener(MouseEvent.CLICK, player.switchStates);
			stage.addEventListener(MouseEvent.CLICK, restart);
		}
		
		/** 
		 * Removes all old pickups, adds new ones, adds and removes new event listeners
		 * @param  e  The mouseclick event
		 */
		private function restart(e: MouseEvent): void
		{
			for(var j: int = 0; j < arrays.length; j++)
			{
				for(var k: int = arrays[j].length - 1; k >= 0; k--)
				{
					removeChild(arrays[j][k]);
					arrays[j].removeAt(k);
				}
			}
			
			player.restart();
			stage.removeEventListener(MouseEvent.CLICK, restart);
			resetScene();
			
			
		}
		
		/** *Adds event listeners, removes game over text, spawns new pickups */
		private function resetScene(): void
		{
			channel.stop();
			channel = music.play(0, 10, new SoundTransform(.5));
			stage.addEventListener(MouseEvent.CLICK, player.switchStates);
			isRunning = true;
			restartText.visible = false;
			gameOver.visible = false;
			spawnSize(30);
			spawnSpeed(5);
			spawnPent(2);
			spawnSpinner(2);
		}
		
		/** *Goes through pickup collections to see if any have collided with the player */
		private function checkCollisions(): void
		{
			for each (var siP: SizePickup in sizePickups)
			{
				if (doesCollide(siP))
				{
					boop.play();
					siP.collide(player);
					spawnSize(1);
					//trace(player.size);
				}
			}
			
			for each (var spP: SpeedPickup in speedPickups)
			{
				if (doesCollide(spP))
				{
					boop.play();
					spP.collide(player);
					spawnSpeed(1);
					//trace(player.size);
				}
			}
			
			for each (var pe: Pent in pentPickups)
			{
				if (doesCollide(pe))
				{
					boop.play();
					pe.collide(player);
					spawnPent(1);
				}
			}
			
			for each (var s: Spinner in spinners)
			{
				if(doesCollide(s))
				{
					s.collide(player);
				}
			}
		}
		
		/** 
		 * Checks if the obj is collided with the player using radial collision detection
		 * @param  obj  The object being tested whether or not it has collided with the player
		 * @return  True if the obj is colliding with the player
		 */
		private function doesCollide(obj: MovieClip): Boolean
		{
			var distance: Number = Math.sqrt(Math.pow((obj.x - player.x), 2) + Math.pow((obj.y - player.y), 2));
			return (distance <= obj.radius + (player.size / 2));
		}
		
		
		
	}
	
}
