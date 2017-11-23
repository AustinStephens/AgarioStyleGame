# AgarioStyleGame
Made in Adobe Animate (ActionScript3)

You are a circle that moves in the direction of your mouse, you can click the left mouse button to change your color (red/blue).
You pick up objects by colliding with them.
You can pick up the small dots, if they are the same color as you, they increase your size and score, if not they decrease your size and score.
You can pick up the squares, if they are the same color as you, they increase your speed, if not they decrease it.
You can pick up the black pentagons, they increase the size/speed you gain from picking up the dots/squares for 5 seconds.
Avoid the black spinners, if you collide with them you die.
Bombs will fall down on to the screen, they are flashing blue/red and black, if you are not the same color as it (blue/red), when it blows up it will kill you.
If you earn 20000 points, you win the game.

This game is made in Adobe Animate to practice coding a game engine. This uses a self made game loop, update functions, radial collision detection, and state machine (for the colors).

There are a few downfalls, when you respawn after dying or winning, you might spawn on a spinner, immediately killing you. 
Also, the pickups tend to gather around the spinners over time. Might fix these when I have the time, right now they will remain this way.
