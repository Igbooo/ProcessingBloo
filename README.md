# ProcessingBloo
My Processing game

# Notes (from bottom of main)
## List of Issues:
* spikes spawn ALWAYS when there is overlap, random needs implemented (1/2, 2/3 ?) (not started)
* jumping along the side and over a platform snaps you to the floor instead of continuing up (maybe its just "movement tech" :^) )
* entering the air without jumping allows you to buffer a jump
* timer makes it so the game has to restart in order for the timer to reset.

## Features to do next
* having platforms move up, despawn off the top, player stay on the ground when they move
* levels, speeds, score when you pass a platform, osd(?), menu, PogU
* MK ghosts :eyes:

## List of old issues that were amusing
* SUMMET IS UP WITH AIRSTATE (ur dumb lol, literally one pixel)
* "list of issues: none" KEKW

# Contents of old READ ME PLEASE.txt
This is the prototype for my falling game project. I decided to first make a "platforming engine" and then later adapt that into what will become my game. Currently the idea is that the platforms spawn in a random layout and you try to get to the top as fast as possible. The games stores your last time in a text file called 'hiScore.txt', at the moment i have not implemented a high score.

The eventual idea is that you have to race to the bottom of the screen as the platforms move past you. if you hit the top you die, if you get to the bottom you move to the next level where the platforms are more frequent/faster. In order to have the timer store the time properly, I have made it so the program ends when you reach the top and press 'R', however there is functionality to have the game restart with a new platform layout, but  it's currently commented out. It would work fine, but the timer works by timing from the time of launch so the timer wouldn't reset when you restarted. 

The only other issue I am aware of is that when you jump along the side of a platform, you will clip onto the ground instead of jumping past it. This is a byproduct of how landing after a jump works, and I haven't decided wether it's a feature or not yet so I haven't fixed it.
