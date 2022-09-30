// ignore_for_file: unnecessary_lambdas

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'country.dart';

class ResponseGetCountries {
  final bool success;
  final String errorMessage;
  final List<Country> countries;

  ResponseGetCountries({
    required this.success,
    required this.errorMessage,
    required this.countries,
  });

  ResponseGetCountries copyWith({
    bool? success,
    String? errorMessage,
    List<Country>? countries,
  }) =>
      ResponseGetCountries(
        success: success ?? this.success,
        errorMessage: errorMessage ?? this.errorMessage,
        countries: countries ?? this.countries,
      );

  Map<String, dynamic> toMap() => {
        'success': success,
        'errorMessage': errorMessage,
        'countries': countries.map((x) => x.toMap()).toList(),
      };

  factory ResponseGetCountries.fromMap(Map<String, dynamic> map) => ResponseGetCountries(
        success: map['success'] ?? false,
        errorMessage: map['errorMessage'] ?? '',
        countries: List<Country>.from(map['countries']?.map((x) => Country.fromMap(x))),
      );

  String toJson() => json.encode(toMap());

  factory ResponseGetCountries.fromJson(String source) => ResponseGetCountries.fromMap(json.decode(source));

  @override
  String toString() => 'ResponseGetCountries(success: $success, errorMessage: $errorMessage, countries: $countries)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ResponseGetCountries && other.success == success && other.errorMessage == errorMessage && listEquals(other.countries, countries);
  }

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode ^ countries.hashCode;
}
