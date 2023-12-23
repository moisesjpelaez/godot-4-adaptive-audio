# Godot 4 Adaptive Audio
Simple adaptive audio plugin for Godot 4.


## Installation
1. Download and extract the 'adaptive-audio' folder under the 'addons' directory.
 

## UI overview
![Godot_v4 2 1-stable_win64_3Up9HG1HQC](https://github.com/moisesjpelaez/godot-4-adaptive-audio/assets/24682046/533196a9-0486-45ea-ad89-6352df5b8aa2)

1. Switches the main tab to the Adaptive Audio view.
2. Stops playing the current track.
3. Adds a new track.
4. Saves the current audio setup as an autoload.
5. Loads a saved audio setup into the view.


## Creating an audio setup
Press 'Add Track':
1. Set the track's name
2. Assign the transition fade time (preview only)
3. Drop the audio file in ogg, mp3 or wav format
4. Optionally select the audio file using the file viewer
5. Plays the track
6. Removes the track from the view

Press 'Add Layer':
1. Transitions to a single layer. If it's in the same track, the base track keeps playing and the previous layer fades out. If it's pressed from a different track, the current track stops and the next track is player with the current layer.
2. Blends in the layer. If it's in the same track, the current layer adds up. Same behavior as 'Transition' if it's pressed from a different track.
3. Removes the current layer.

Add as many tracks or layers as you like:


Save the current setup:
It creates an AdaptiveAudio.tscn file and automatically adds it as an autoload in the current project

If you close Godot you can load your saved saved setup:
   

## Playing tracks with code
