class NeoPixel {
  int number;
  int screenX;
  int screenY;
  int sampleLoc;
  float radius;
  color currentCol = color(0,0,0);
  
  NeoPixel(int _x, int _y, float _radius, int _num, int videoWidth) {
    sampleLoc = _x + _y * videoWidth;
    screenX = round(map(_x, 0, 640, 0, width));
    screenY = round(map(_y, 0, 480, 0, height));
    radius = _radius;
    number = _num;
  }
  
  void show(Movie video, byte[] colorData) {
    try {
      if (video.pixels != null && sampleLoc < video.pixels.length) {
        currentCol = video.pixels[sampleLoc];
      }
    } catch (Exception e) {
      // Keep current color
    }
    
    colorData[number * 3] = (byte)((currentCol >> 16) & 0xFF);
    colorData[number * 3 + 1] = (byte)((currentCol >> 8) & 0xFF);
    colorData[number * 3 + 2] = (byte)(currentCol & 0xFF);
    
    fill(currentCol);
    circle(screenX, screenY, radius);
  }
}
