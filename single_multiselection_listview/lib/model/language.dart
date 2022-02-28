import 'package:meta/meta.dart';

class Language {
  final String name;
  final String nativeName;


  const Language({
     required this.name,
     required this.nativeName,

  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    name: json['name'],
    nativeName: json['nativeName'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Language &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              nativeName == other.nativeName;

  @override
  int get hashCode => name.hashCode ^ nativeName.hashCode;
}