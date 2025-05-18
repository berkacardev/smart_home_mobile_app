abstract class IconConstants{
  static const String temperatureIconPath = "temperature_icon";
  static const String lockedIconPath = "locked";
  static const String unlockedIconPath = "unlocked";
  static const String cctvIconPath = "cctv_icon";
  static const String bulbOpenPath = "bulb_open";
  static const String bulbClosePath = "bulb_close";

  static String getIconAsPNG(String iconPath){
    return "assets/icons/$iconPath.png";
  }
}