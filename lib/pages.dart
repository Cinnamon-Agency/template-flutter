import 'package:get/get.dart';

import 'screens/hello/hello_binding.dart';
import 'screens/hello/hello_screen.dart';

///
/// All pages used in the application
/// Also linked to the relevant bindings in order to
/// initialize / dispose proper controllers when neccesarry
///

final pages = [
  GetPage(
    name: MyRoutes.helloScreen,
    page: HelloScreen.new,
    binding: HelloBinding(),
  ),
];

/// All pages have their designated names which can be found here
class MyRoutes {
  static const helloScreen = '/hello_screen';
}
