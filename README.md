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
1. Press 'Add Track'
   a. Set the track's name
   b. Assign the transition fade time (preview only)
   c. Drop the audio file in ogg, mp3 or wav format
   d. Optionally select the audio file using the file viewer
   e. Plays the track
   f. Removes the track from the view
2. Press 'Add Layer'
   a. Transitions to a single layer. If it's in the same track, the base track keeps playing and the previous layer fades out. If it's pressed from a different track, the current track stops and the next track is player with the current layer.
   b. Blends in the layer. If it's in the same track, the current layer adds up. Same behavior as 'Transition' if it's pressed from a different track.
   c. Removes the current layer.
3. Add as many tracks or layers as you like
4. Save the current setup
   a. It creates an AdaptiveAudio.tscn file and automatically adds it as an autoload in the current project
5. If you close Godot you can load your saved saved setup
   

## Playing tracks with code
