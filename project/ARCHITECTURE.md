# Architecture

This detail contains information as to how the game is architectured code/scene wise

## Rooms

The game is broken up into rooms which you write in separate scenes.

Each of which needs a parent node that inherits the room.gd script, then a child node that contains the collider for the room on layer 5. The parent node should have the adjacent room ids (their file names minus the .tscn) listed so it knows which rooms to join with. Note that the global positioning of the rooms has to properly align with those adjacent rooms.