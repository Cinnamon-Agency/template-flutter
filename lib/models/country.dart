import 'dart:convert';

class Country {
  final String name;
  final String capital;
  final String anthem;
  final String president;
  final int sqareKm;
  final int callingCode;

  Country({
    required this.name,
    required this.capital,
    required this.anthem,
    required this.president,
    required this.sqareKm,
    required this.callingCode,
  });

  Country copyWith({
    String? name,
    String? capital,
    String? anthem,
    String? president,
    int? sqareKm,
    int? callingCode,
  }) =>
      Country(
        name: name ?? this.name,
        capital: capital ?? this.capital,
        anthem: anthem ?? this.anthem,
        president: president ?? this.president,
        sqareKm: sqareKm ?? this.sqareKm,
        callingCode: callingCode ?? this.callingCode,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'capital': capital,
        'anthem': anthem,
        'president': president,
        'sqareKm': sqareKm,
        'callingCode': callingCode,
      };

  factory Country.fromMap(Map<String, dynamic> map) => Country(
        name: map['name'] ?? '',
        capital: map['capital'] ?? '',
        anthem: map['anthem'] ?? '',
        president: map['president'] ?? '',
        sqareKm: map['sqareKm']?.toInt() ?? 0,
        callingCode: map['callingCode']?.toInt() ?? 0,
      );

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) => Country.fromMap(json.decode(source));

  @override
  String toString() => 'Country(name: $name, capital: $capital, anthem: $anthem, president: $president, sqareKm: $sqareKm, callingCode: $callingCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Country &&
        other.name == name &&
        other.capital == capital &&
        other.anthem == anthem &&
        other.president == president &&
        other.sqareKm == sqareKm &&
        other.callingCode == callingCode;
  }

  @override
  int get hashCode => name.hashCode ^ capital.hashCode ^ anthem.hashCode ^ president.hashCode ^ sqareKm.hashCode ^ callingCode.hashCode;
}
