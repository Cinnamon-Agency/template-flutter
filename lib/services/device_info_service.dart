import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

import 'logger_service.dart';

class DeviceInfoService extends GetxService {
  final logger = Get.find<LoggerService>();

  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final deviceInfo = DeviceInfoPlugin();

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iOSInfo;
  WebBrowserInfo? webBrowserInfo;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  Future<void> onInit() async {
    super.onInit();
    await initProperInfo();
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Logs proper info depending on the platform running the app
  Future<void> initProperInfo() async {
    if (GetPlatform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      logger
        ..v('DEVICE INFO')
        ..v('--------------------')
        ..v('Platform: Android')
        ..v('--------------------\n');
    }
    if (GetPlatform.isIOS) {
      iOSInfo = await deviceInfo.iosInfo;
      logger
        ..v('DEVICE INFO')
        ..v('--------------------')
        ..v('Platform: iOS')
        ..v('--------------------\n');
    }
    if (GetPlatform.isWeb) {
      webBrowserInfo = await deviceInfo.webBrowserInfo;
      logger
        ..v('DEVICE INFO')
        ..v('--------------------')
        ..v('Platform: Web')
        ..v('--------------------\n');
    }
  }
}
