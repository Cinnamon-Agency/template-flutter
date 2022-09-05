import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'logger_service.dart';

class PackageInfoService extends GetxService {
  final logger = Get.find<LoggerService>();

  /// ---------------------------
  /// VARIABLES
  /// ---------------------------

  late final PackageInfo packageInfo;

  late final String appName;
  late final String packageName;
  late final String version;
  late final String buildNumber;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  Future<void> onInit() async {
    super.onInit();

    packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    logger
      ..v('PACKAGE INFO')
      ..v('--------------------')
      ..v('AppName: $appName\nVersion: $version\nBuildNumber: $buildNumber')
      ..v('--------------------\n');
  }
}
