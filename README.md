# Godot 4 Adaptive Audio
Simple adaptive audio plugin for Godot 4.


## Installation
1. Download and extract the 'adaptive-audio' folder under the 'addons' directory.


## General overview
![Godot_v4 2 1-stable_win64_3Up9HG1HQC](https://github.com/moisesjpelaez/godot-4-adaptive-audio/assets/24682046/533196a9-0486-45ea-ad89-6352df5b8aa2)

1. Switches the main tab to the Adaptive Audio view.
2. Stops playing the current track.
3. Adds a new track.
4. Saves the current audio setup as an autoload.
5. Loads a saved audio setup into the view.


## Creating an audio setup
**Press 'Add Track':**

![Godot_v4 2 1-stable_win64_1lCAePw750](https://github.com/moisesjpelaez/godot-4-adaptive-audio/assets/24682046/871557c5-73d6-4cb9-8059-b62eb99d03c7)

![Godot_v4 2 1-stable_win64_uDS0nehvw2](https://github.com/moisesjpelaez/godot-4-adaptive-audio/assets/24682046/74c65a23-2e4a-4ac9-81dc-a49b57b6c2ff)
1. Set the track's name
2. Assign the transition fade time (preview only)
3. Drop the audio file in ogg, mp3 or wav format
4. Optionally select the audio file using the file viewer
5. Plays the track
6. Removes the track and all it's layers from the view

**Press 'Add Layer' from the bottom:**

![Godot_v4 2 1-stable_win64_dHCmdmHKwd](https://github.com/moisesjpelaez/godot-4-adaptive-audio/assets/24682046/d547b36a-04a6-49d8-bcfd-4801827d6a25)
1. Transitions to a single layer. If it's in the same track, the base track keeps playing and the previous layer fades out. If it's pressed from a different track, the current track stops and the next track is player with the current layer.
2. Blends in the layer. If it's in the same track, the current layer adds up. Same behavior as 'Transition' if it's pressed from a different track.
3. Removes the current layer.

**Add as many tracks and layers as you like:**
_ _Also assign audio files, set fade times and test trantitions; play around..._ _

![Godot_v4 2 1-stable_win64_o2Ff8TY1hI](https://github.com/moisesjpelaez/godot-4-adaptive-audio/assets/24682046/ca301e1e-9e96-46f6-a60e-2c7fa926576d)

**Save the current setup:**

![Godot_v4 2 1-stable_win64_jsbSbdQkWM](https://github.com/moisesjpelaez/godot-4-adaptive-audio/assets/24682046/22e68218-d076-4ed9-ac91-e8f2a85ea45c)


It creates an AdaptiveAudio.tscn file and automatically adds it as an autoload in the current project

If you close Godot you can load your saved saved setup:
  
\
\
## Playing tracks with code
