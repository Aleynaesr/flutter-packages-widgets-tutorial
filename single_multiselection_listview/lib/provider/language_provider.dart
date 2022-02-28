import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:single_multiselection_listview/model/language.dart';
import 'package:single_multiselection_listview/model/utils.dart';

class LanguageProvider with ChangeNotifier {
  LanguageProvider() {
    loadLanguages().then((languages) {
      _languages = languages;
      notifyListeners();
    });
  }

  List<Language> _languages = [];

  List<Language> get languages => _languages;

  Future loadLanguages() async {
    final data = await rootBundle.loadString('assets/languages.json');
    final languagesJson = json.decode(data);

    return languagesJson.keys.map<Language>((code) {
      final json = languagesJson[code];
      final newJson = json..addAll({'code': code.toLowerCase()});

      return Language.fromJson(newJson);
    }).toList()
      ..sort(Utils.ascendingSort);
  }
}
