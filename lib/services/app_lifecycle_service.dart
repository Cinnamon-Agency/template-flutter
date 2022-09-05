import 'package:get/get.dart';

import 'logger_service.dart';

/// Trigers methods when the app goes in a different state
class AppLifecycleService extends FullLifeCycleController with FullLifeCycleMixin {
  final logger = Get.find<LoggerService>();

  @override
  void onDetached() {
    logger.v('[ONDETACHED]');
  }

  @override
  void onInactive() {
    logger.v('[ONINACTIVE]');
  }

  @override
  void onPaused() {
    logger.v('[ONPAUSED]');
  }

  @override
  void onResumed() {
    logger.v('[ONRESUMED]');
  }
}
