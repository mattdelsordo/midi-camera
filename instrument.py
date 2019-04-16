# MIDI instrument that sends signals based on how an
# object moves within the camera frame
import cv2
import numpy as np
import pprint
pp = pprint.PrettyPrinter(indent=4)

# Size of the grid that the image is split into
GRID_SIZE = 8
last_visited = [([False]*GRID_SIZE) for i in range(GRID_SIZE)]
active_squares = [([False]*GRID_SIZE) for i in range(GRID_SIZE)]
chunkX = 0
chunkY = 0

# Below this intensity (0-255), don't include in the diff
DIFF_THRESHOLD = 50

# Open window, start video capture
cv2.namedWindow("feed")
cap = cv2.VideoCapture(0)

# Try to open the webcam, print message if it fails
if cap.isOpened():
    ret, img1 = cap.read()
    imgX, imgY, imgChannels = img1.shape
    chunkX = imgX / GRID_SIZE
    chunkY = imgY / GRID_SIZE
    print("x:", imgX, "y:", imgY, "chunk size:", chunkX, chunkY)
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
            if (np.count_nonzero(gray[startX:startX+chunkX, startY:startY+chunkY]) > 1):
                # if the object wasn't here in the last frame, toggle the square
                if not last_visited[x][y]:
                    active_squares[x][y] = not active_squares[x][y]
                last_visited[x][y] = True
            else:
                last_visited[x][y] = False

            # add image indicator to img2
            if active_squares[x][y]:
                print(startX,startX+chunkX, startY,startY+chunkY)
                img2[startX:startX+chunkX, startY:startY+chunkY, 2] += 50  

    # Display difference between the frames on the window
    cv2.imshow("feed", img2)

    # Set last frame to the new curent frame
    img1 = img2

    # ESC to quit
    if cv2.waitKey(1) == 27:
        break

# When everything done, release the capture and clean up
cap.release()
cv2.destroyAllWindows()
