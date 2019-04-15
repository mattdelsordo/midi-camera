# MIDI instrument that sends signals based on how an
# object moves within the camera frame
import numpy as np
import cv2

# Open window, start video capture
cv2.namedWindow("webcam")
cap = cv2.VideoCapture(0)

# Try to open the webcam, print message if it fails
if cap.isOpened():
    ret, img = cap.read()
else:
    print("Webcam not opened (try another device id?)")
    ret = False    

while(ret):
    # Display last frame on window
    cv2.imshow("webcam",img)

    # Capture new frame
    ret, img = cap.read()

    # Our operations on the frame come here
    #gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # ESC to quit
    if cv2.waitKey(1) == 27:
        break

# When everything done, release the capture and clean up
cap.release()
cv2.destroyAllWindows()
