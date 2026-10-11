# Game concept

The game 'man of masks' is a 2d side scroller platformer where you can phase in and out of different worlds by changing the mask you are wearing. Different game mechanics and obstacles are available depending on which mask you are wearing. The idea comes from a Game Jam game.

# Mechanics

## Game layout and checkpointing system

#### Original concept for reference

The original Game Jam game had a single level broken up into checkpoints that you can hit once and never again later on. It featured some backtracking where you would go through a section of the level you had already been through, but because you had unlocked new masks it meant that you could reach new parts you otherwise could not reach before. The new game layout proposal fits better with a larger game

#### Game layout

Levels are broken into seamlessly connected levels (or 'screens') that connect all together in one big map, think something like Celeste or Hollow knight. Each of these levels acts as its own checkpoint and there are no physical checkpoints in the game.

Some element of going back to previously visited levels will be expected, where unlocking new masks or other key items will let you progress to a new area of the game that you otherwise weren't able to before. But the game is not expected to be like a Hollow Knight metroidvania which is more exploratory. This game is expected to be a bit more linear. Some elements of path choice selection could be expected.

Whether there will be separate levels or one seamlessly connected area for the whole game could depend on how the game pans out.

#### Death mechanics

Similar to how Celeste works with death mechanics.

Each level will need to have hidden checkpoints that indicate where you spawn if you die. Usually the 'start' of the level. But if you were to go to the end and backtrack it might set a new checkpoint on the other side.

## Mask switching

I see 2 realistic paths we can go for the game

#### Original concept for reference

1 state is having no mask, then 2 other masks you could collect. If you press '1', you return to default state. If you press '2' you go to your blue mask, if you press '3' you go to your red mask. This is limited in scope for building a game in a certain length of time.

What we want to bring forward from this is the quick nature of switching between the masks seamlessly by pressing a button. But make it work better for controller and scaling between for more masks.

#### Concept 1 - 3 masks max

D pad down = default state
Other D pad options = each individual mask

On Keyboard this would be the numbers 1-4

With this this more limited option we can reserve a button for each mask in the whole game and the player does not need to re-learn button presses for each mask.

The game flow would be that you have ideally collected all 3 when you are about 50% of the way through the game. Each of the masks would carry more identity and would feature a lot throughout the game 

#### Concept 2 - masks limited to 2 per area

Controls would be: R1 = activate/deactivate mask 1 and L1 = activate/deactivate mask 2. In any particular area you will only have 2 masks = maximum of 3 different states you can be in.

The way that this can be controlled could be that there are item versions of the masks you pick up and some sort of checkpoint or item that would wipe your masks and you'd need to recollect them to pick them back up.


#### Comparison of concepts

**More focussed list of masks**: Concept 1
**More freedom to explore more experimental mask ideas**: Concept 2
**More focussed level design**: Concept 2. Each area we can focus on a certain mask more easily. For example: in the original game jam game the first mask is completely pointless in the fire section of the game. We can completely disable masks like these in areas like this and make it a core part of the game that only some masks are available at a time. 
**More 'backtrackable' level design** Concept 1. In concept 2 if you want to make an area where you need to 'unlock' a mask later on to be able to progress in it in a different way, you need to add some sort of way that the unlocked mask. You can still make backtrackeable level design for concept 2 it just won't be as centred on using certain mask abilities.

Overall:

Concept 1 = leans to more exploratory gameplay and more backtrackable levels with more fleshed out lore and design for each of the masks. Eg: each mask could be a different time period on earth.
Concept 2 = gameplay will be more linear and focused and the masks can introduce more unique mechanics.

I do lean toward concept 2 because it means in every area with 3 masks available we need to think about how it appears in every mask format, whereas it probably makes more sense just to go with 1.