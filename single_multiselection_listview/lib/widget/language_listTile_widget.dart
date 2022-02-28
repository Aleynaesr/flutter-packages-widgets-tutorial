
import 'package:flutter/material.dart';
import 'package:single_multiselection_listview/model/language.dart';
import 'package:single_multiselection_listview/thema/constant.dart';

class LanguageListTileWidget extends StatelessWidget {
  final Language language;
  final bool isNative;
  final bool isSelected;
  final ValueChanged<Language> onSelectedCountry;

  const LanguageListTileWidget({
    Key? key,
    required this.language,
    required this.isNative,
    required this.isSelected,
    required this.onSelectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = textColor;
    final style = isSelected
        ? TextStyle(
      fontSize: 18,
      color: selectedColor,
      fontWeight: FontWeight.bold,
    )
        : TextStyle(fontSize: 18);

    return ListTile(
      onTap: () => onSelectedCountry(language),
      title: Text(
        isNative ? language.nativeName : language.name,
        style: style,
      ),
      trailing:
      isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}