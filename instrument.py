# MIDI instrument that sends signals based on how an
# object moves within the camera frame
import numpy as np
import cv2

# Open window, start video capture
cv2.namedWindow("webcam")
cap = cv2.VideoCapture(0)

# Try to open the webcam, print message if it fails
if cap.isOpened():
    ret, img1 = cap.read()
else:
    print("Webcam not opened (try another device id?)")
    ret = False    

while(ret):
    # Capture new frame
    ret, img2 = cap.read()

    # Calculate difference between this frame and the last frame
    diff = cv2.absdiff(img1, img2)
    mask = cv2.cvtColor(diff, cv2.COLOR_BGR2GRAY) #grayscale it

    # Display difference between the frames on the window
    cv2.imshow("webcam",mask)

    # Set last frame to the new curent frame
    img1 = img2

    # ESC to quit
    if cv2.waitKey(1) == 27:
        break

# When everything done, release the capture and clean up
cap.release()
cv2.destroyAllWindows()
