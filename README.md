# :notes: MIDI Camera :camera:
This project was originally created by Matt DelSordo and Fayth Kim as part of a final project for AME 196 at the University of Rochester. Originally, we used it to track a hamster's movement through an area in order to trigger sound loops to mix a hamster-oriented piece of music (see the [program notes](#original-program-notes) below). The code is a lot more versatile than just that though and you could hypothetically point it at anything to organically compose a piece of music from the content of a video feed.

## Dependencies :wrench:
* [OpenCV](https://docs.opencv.org/3.0-beta/doc/py_tutorials/py_setup/py_setup_in_windows/py_setup_in_windows.html), also, [unofficial pypi version](https://pypi.org/project/opencv-python/)
* [Mido](https://pypi.org/project/mido/)
* [ChucK](http://chuck.cs.princeton.edu/) (to run example code)

## Running his :running:
### MIDI camera
Running `python midi-camera.py` will open a full screen video feed on whatever camera your machine treats as port 0 and begin emitting MIDI signals. Run our [example code](#example-project) to see what _we_ did with this, but with some tweaking it could be used for a variety of fun musical activities. `midi-camera.py` has the following optional flags:
* `--listout, -l`: lists the ports available for MIDI output
* `--input, -i`: sets the video device port (default is 0)
* `--output, -o`: sets the MIDI output port (default is 0)
* `--grid, -g`: sets # of squares in drum pad display (default is 4 for a 4x4 grid)
* `--debug, -d`: enters debug mode which exits fullscreen and displays a second display of the raw movement data, along with console output


### Example project
In the `example/` directory, run `./run.sh`. This assumes you have an external camera plugged in to your computer and ChucK installed. You can also use the following files for debugging:
* `midi_camera_test.ck` will play a piano note given arbitrary MIDI input
* `sound-test.sh` will trigger all sound effects at once

## Future work :bug:
Two things currently bug me:
1. Intense light or glare picked up by the camera will be treated as non-stop, static "movement" by the script, so if a chunk of the "drum pad" contains glare and is triggered it will never be able to be un-triggered (other than by completely covering the source of the glare).
2. Related to #1, sources of glare show up bright blue in active chunks in the video output. My guess is that this is because, to color the chunks red, the script just adds to the red-value of each pixel in the chunk, which causes overflow (or something?) where the red-value is already high (the glare). 

## Original program notes :hamster:
#### Title: Beats by Hammy
#### By: Fayth Kim and Matt DelSordo
Often times, DJs just don't know what the crowd wants. That is why we put the important task of creating the music to a pet hamster named Wasabi. The program functions by generating sounds as Wasabi runs in his ball. Using a webcam that is mounted above a square fencing (in order to keep Wasabi in an enclosed area), python scripts using OpenCV were used to detect whether Wasabi runs in or out of defined 4x4 grid squares. All the squares are initialized as 'off', but if Wasabi runs into a square, pixel color changes trigger it as 'on' (and vice versa), where midi signals then are sent to chuck where the midi messages are processed. In the 4x4 grid, each 1x1 square is assigned a different sound pattern or song (w/ respective .ck files). The generated sound files were a curated selection of hamster/rodent noises, well-known hamster-based tunes, and drum patterns. For a better listening experience in the generated song, the BPM of the 'Hamster Dance' song (136) was used as a standard in which other BPMs were to. In addition, a queue was made for each midi/chuck process so that sound files were either turned off or on on the first down beat. DJ Wasabi the hamster may choose to create a different mix each time which results in unforgettable performances every time!
