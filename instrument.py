# MIDI instrument that sends signals based on how an
# object moves within the camera frame
import argparse
import cv2
import numpy as np
import mido
# import pprint
# pp = pprint.PrettyPrinter(indent=4)

# Configure command-line argument parser
ap = argparse.ArgumentParser()
ap.add_argument('--listout', "-l", action="store_true", help="list available output ports")
ap.add_argument('--input', "-i", default=0, help="set video device number (default: 0)")
ap.add_argument('--output', "-o", default=0, help="set output port (default: first available port)")
ap.add_argument('--grid', "-g", default=4, help="set number of squares in drum pad grid (default: 4)")
ap.add_argument('--debug', "-d", action="store_true", help="enable debug mode")
args = ap.parse_args()

if args.listout:
    print("Available ports: " + str(mido.get_output_names()))
    exit()
DEBUG = args.debug

# Size of the grid that the image is split into
GRID_SIZE = int(args.grid)
last_visited = [([False]*GRID_SIZE) for i in range(GRID_SIZE)]
active = [([False]*GRID_SIZE) for i in range(GRID_SIZE)]
chunkX = 0
chunkY = 0

# Below this intensity (0-255), don't include in the diff
DIFF_THRESHOLD = 50
# Amount of pixels in a square for it to count as activated
ACTIVE_PIXEL_THRESHOLD = 1

# Set up MIDI out stuff
out_port = mido.get_output_names()[int(args.output)]
print("Output on port " + out_port)
port = mido.open_output(out_port)

# Trigger note0on signal
def noteOn(note):
    msg = mido.Message('note_on', note=note)
    port.send(msg)
    if DEBUG: print(msg)

# Trigger note-off signal
def noteOff(note):
    msg = mido.Message('note_off', note=note)
    port.send(msg)
    if DEBUG: print(msg)

# "Toggle" note on or off
def toggleNote(x, y, status):
    note = (y * GRID_SIZE) + x
    
    # Note on if note was not previously on
    if (status):
        if DEBUG: print("Note on", x, y)
        noteOn(note)
    # Note off if note WAS on and is not anymore    
    else:
        if DEBUG: print("Note off", x, y)
        noteOff(note)

# Open window, start video capture
cv2.namedWindow("feed")
if DEBUG: cv2.namedWindow("grayscale")
cap = cv2.VideoCapture(args.input)
print("Input on video device " + str(args.input))

# Try to open the webcam and initialize constants
# print message if it fails
if cap.isOpened():
    ret, img1 = cap.read()
    imgX, imgY, imgChannels = img1.shape
    chunkX = imgX / GRID_SIZE
    chunkY = imgY / GRID_SIZE
    if DEBUG: print("chunks:", GRID_SIZE, "img x:", imgX, "img y:", imgY, "chunk size:", chunkX, chunkY)
else:
    print("Webcam not opened (try another device id?)")
    ret = False    

while(ret):
    # Capture new frame
    ret, img2 = cap.read()

    # Calculate difference between this frame and the last frame
    diff = cv2.absdiff(img1, img2)
    gray = cv2.cvtColor(diff, cv2.COLOR_BGR2GRAY) #grayscale it
    # ENHANCE
    gray[gray >= DIFF_THRESHOLD] = 255
    gray[gray < DIFF_THRESHOLD] = 0
    
    # Operate on each square of the diff
    for x in range(0, GRID_SIZE):
        for y in range(0, GRID_SIZE):
            startX = x * chunkX
            startY = y * chunkY

            # check each chunk for the presence of an object
            chunk_count = np.count_nonzero(gray[startX:startX+chunkX, startY:startY+chunkY])
            # If object is present...
            if (chunk_count > ACTIVE_PIXEL_THRESHOLD):
                # if the object wasn't here in the last frame,
                # toggle the square and play the note
                if not last_visited[x][y]:
                    active[x][y] = not active[x][y] # update the state
                    toggleNote(x, y, active[x][y]) # toggle the note
                # update state
                last_visited[x][y] = True
            # Otherwise, only update state
            else:
                last_visited[x][y] = False

            # If a square is active, color it red in the video feed
            if active[x][y]:
                img2[startX:startX+chunkX, startY:startY+chunkY, 2] += 50

    # Update video feed
    cv2.imshow("feed", img2)
    if DEBUG: cv2.imshow("grayscale", gray)

    # Set last frame to the new curent frame
    img1 = img2

    # ESC to quit
    if cv2.waitKey(1) == 27:
        break

# When everything done, release the capture and clean up
cap.release()
cv2.destroyAllWindows()
