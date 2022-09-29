import 'package:alice/alice.dart';
import 'package:get/get.dart';

class AliceService extends GetxService {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final alice = Alice();

  /// ------------------------
  /// METHODS
  /// ------------------------

  void openAlice() => alice.showInspector();
}
