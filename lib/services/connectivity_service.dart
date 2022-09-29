import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'logger_service.dart';

class ConnectivityService extends GetxService {
  final logger = Get.find<LoggerService>();

  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final connectivityListener = Connectivity().onConnectivityChanged.listen((result) => logger
    ..v('CONNECTIVITY')
    ..v('--------------------')
    ..v('New connectivity status')
    ..v('$result')
    ..v('--------------------\n'));
}
