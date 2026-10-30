# Architecture

This detail contains information as to how the game is architectured code/scene wise

## Rooms

The game is broken up into rooms which you write in separate scenes.

What you need in each room:

- needs an ID and it should be stored in world/rooms/ID.tscn
- A Node2D that inherits the room script.
    - The adjacent room ids list needs to contain a list of the ids of rooms that are adjacent to it. Basically when you are in the room these rooms will be loaded next to it
- RoomBorder/RoomBorderCollision
    - This covers the whole collision of the room. The edge should seamlessly connect to any adjacent rooms.
- Checkpoints
    - Contains marker 2ds of any name that reflect different checkpoint spawnpoints you can spawn at. The spawnpoint of the room is decided as the closest checkpoint you are near to when you enter the room (or otherwise activate an item that triggers a new checkpoint to be selected, which is not ready yet)
- TileMapLayer

## Collectable items

- Make a Node2D that extends temporary_object.gd and give it a unique id to the world. This tells the global state if you have collected this item or not.
- Inside, have an Area2D object that extends collectable.gd, then give it an item_id. This tells you the id of the type of item. Eg: if there are 2 keys in the world, these could have the same item_id but require a different object_id for the temporary object script
    - the 2d area object has a collision which has the mask at layer 2


## Locks

- Make a Node2D that extends temporary_object.gd and give it a unique id to the world. This tells the global state if you unlocked this or not
- Inside this have the wall object that prevents you from going through
- Also inside the temporary object node you should have an unlock area that extends unlockable.gd. This basically gives you an area where if the player was to enter the key will be used. The key_id should be set to represent the item_id of the type of key you want to be interactable with this