import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/country.dart';
import '../../models/response_get_countries.dart';
import '../../services/dio_service.dart';
import '../../services/logger_service.dart';

///
/// This is a controller in which we write logic concerning [HelloScreen]
/// The controller uses a [StateMixin]
/// We pass a variable type to the mixin and then get access to the `change` method
/// We can set different states with it and then render proper Widget depending on the state
///

class HelloController extends GetxController with StateMixin<List<Country>> {
  ///
  /// DEPENDENCIES
  ///

  final logger = Get.find<LoggerService>();

  ///
  /// INIT
  ///

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchCountries();
  }

  ///
  /// METHODS
  ///

  /// Fetches coutries from an endpoint
  /// Usually using [DioService], but currently we'll fetch a local hardcoded JSON
  Future<void> fetchCountries() async {
    try {
      /// Simulate a network call
      await Future.delayed(const Duration(seconds: 3));

      /// Fetch data from the backend
      final response = await rootBundle.loadString('assets/countries_json.json');

      /// Parse fetched response
      final parsedResponse = ResponseGetCountries.fromMap(json.decode(response));
      // final parsedResponse = await computeGetCountries(json.decode(response));
      logger.logJson(response);

      /// Update state with parsed response
      updateState(parsedResponse.countries);
    } catch (e) {
      change(null, status: RxStatus.error('Error has happened: $e'));

      logger
        ..e('HELLOCONTROLLER')
        ..e('--------------------')
        ..e("Error in 'fetchCountries()'")
        ..e('$e')
        ..e('--------------------\n');
    }
  }

  /// Used to parse the response using isolates
  Future<ResponseGetCountries> computeGetCountries(data) async => compute(parseGetCountries, data);
  ResponseGetCountries parseGetCountries(data) => ResponseGetCountries.fromMap(data);

  /// Updates state, depending on fetched countries
  void updateState(List<Country> newState) => change(
        newState,
        status: newState.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
}
