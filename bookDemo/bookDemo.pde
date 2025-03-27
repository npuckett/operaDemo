import processing.video.*;
import ch.bildspur.artnet.*;
import controlP5.*;

String[] videoFiles = {
  "glitch2Badge.mov",
  "loading.mov",
  "redChase.mov",
  "futureColour.mov"
};

float[] videoDurations = {30, 45, 30, 45};
float[] videoSpeeds = {0.4, 2.5, 0.4, 2.6};

int currentVideoIndex = 0;
float sequenceStartTime = 0;
String deviceIP = "192.168.137.10";
Universe currentUniverse;
ArtNetDevice device;

// Frame timing
int lastFrameTime = 0;
int frameInterval = 25;  // 40fps max

void setup() {
  size(1920, 1080);
  frameRate(40);
  
  device = new ArtNetDevice(0, deviceIP);
  currentUniverse = new Universe(this, 0, 0, videoFiles[0], 0, 104, true, true, 72, new String[]{deviceIP}, videoSpeeds[0]);
  sequenceStartTime = millis();
}

void draw() {
  int currentTime = millis();
  if (currentTime - lastFrameTime < frameInterval) return;
  lastFrameTime = currentTime;
  
  if (currentTime - sequenceStartTime >= videoDurations[currentVideoIndex] * 1000) {
    currentVideoIndex = (currentVideoIndex + 1) % videoFiles.length;
    currentUniverse = new Universe(
      this, 0, 0, videoFiles[currentVideoIndex], 
      0, 104, true, true, 72, 
      new String[]{deviceIP}, videoSpeeds[currentVideoIndex]
    );
    sequenceStartTime = currentTime;
  }
  
  currentUniverse.show();
  
  if (currentUniverse.colorData != null) {
    device.sendColorData(currentUniverse.colorData);
  }
}

void movieEvent(Movie m) {
  m.read();
}
