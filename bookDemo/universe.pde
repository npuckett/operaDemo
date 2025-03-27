class Universe {
  Movie controlAnimation;
  byte[] colorData;
  ArrayList<NeoPixel> pixelList;
  float playbackSpeed = 1.0f;
  
  Universe(PApplet p, float _displayX, float _displayY, String animationPath, int _uNumber, 
           int _totalLEDs, boolean _badge, boolean _collar, int _collarLength, String _ips[], float defSpeed) {
    
    playbackSpeed = defSpeed;
    
    // Initialize arrays
    colorData = new byte[_totalLEDs * 3];
    pixelList = new ArrayList<NeoPixel>(_totalLEDs);
    
    // Load and setup animation
    controlAnimation = new Movie(p, animationPath);
    controlAnimation.loop();
    controlAnimation.speed(playbackSpeed);
    
    // Setup LED layout
    int index = 0;
    float ledRadius = min(width, height) / 20;
    
    if(_badge) {
      int ledGrid1_xDim = 8;
      int ledGrid1_yDim = 4;
      int ledGrid1_xPos = 100;
      int ledGrid1_yPos = 100;
      int ledGrid1_spacing = 60;
      
      for(int y = 0; y < ledGrid1_yDim; y++) {
        for (int x = 0; x < ledGrid1_xDim; x++) {
          int localX = ledGrid1_xPos + ledGrid1_spacing * x;
          int localY = ledGrid1_yPos + ledGrid1_spacing * y;
          pixelList.add(new NeoPixel(localX, localY, ledRadius, index, 640));  // Fixed width
          index++;
        }
      }
    }
    
    if(_collar) {
      ledRadius = min(width, height) / 30;
      for (int i = 0; i < _collarLength; i++) {
        int localX = round(map(i, 0, (_collarLength-1), 20, 620));
        pixelList.add(new NeoPixel(localX, 400, ledRadius, index, 640));  // Fixed width
        index++;
      }
    }
  }
  
  void show() {
    if(controlAnimation.available()) {
      controlAnimation.read();
    }
    
    background(0);
    noStroke();
    
    controlAnimation.loadPixels();
    if (controlAnimation.pixels != null && controlAnimation.pixels.length > 0) {
      for (NeoPixel p : pixelList) {
        p.show(controlAnimation, colorData);
      }
    }
  }
}
