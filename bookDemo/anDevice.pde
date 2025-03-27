// Modified ArtNetDevice class (ArtNetDevice.pde)
class ArtNetDevice {
  ArtNetClient artnet;
  int uNumber;
  String deviceIP;

  ArtNetDevice(int uNumber, String deviceIP) {
    this.uNumber = uNumber;
    this.deviceIP = deviceIP;
    artnet = new ArtNetClient(null);
    artnet.start();
  }

  void sendColorData(byte[] colorData) {
    artnet.unicastDmx(this.deviceIP, this.uNumber, 0, colorData);
  }
}
