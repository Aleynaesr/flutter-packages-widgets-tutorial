import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_multiselection_listview/model/language.dart';
import 'package:single_multiselection_listview/model/utils.dart';
import 'package:single_multiselection_listview/provider/language_provider.dart';
import 'package:single_multiselection_listview/thema/constant.dart';
import 'package:single_multiselection_listview/widget/language_listTile_widget.dart';
import 'package:single_multiselection_listview/widget/search_widget.dart';

class LanguagePage extends StatefulWidget {
  final bool isMultiSelection;
  final List<Language> languages;

  const LanguagePage({
    Key? key,
    this.isMultiSelection = false,
    this.languages = const [],
  }) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String text = '';
  List<Language> selectedLanguages = [];
  bool isNative = false;

  @override
  void initState() {
    super.initState();

    selectedLanguages = widget.languages;
  }

  bool containsSearchText(Language language) {
    final name = isNative ? language.nativeName : language.name;
    final textLower = text.toLowerCase();
    final languageLower = name.toLowerCase();

    return languageLower.contains(textLower);
  }

  List<Language> getPrioritizedLanguages(List<Language> languages) {
    final notSelectedLanguages = List.of(languages)
      ..removeWhere((language) => selectedLanguages.contains(language));

    return [
      ...List.of(selectedLanguages)..sort(Utils.ascendingSort),
      ...notSelectedLanguages,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final allLanguages = getPrioritizedLanguages(provider.languages);
    final languages = allLanguages.where(containsSearchText).toList();

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: languages.map((language) {
                final isSelected = selectedLanguages.contains(language);
                return Card(
                  shadowColor: textColor,
                  color: white,
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 6.0),
                  child: LanguageListTileWidget(
                    language: language,
                    isNative: isNative,
                    isSelected: isSelected,
                    onSelectedCountry: selectLanguage,
                  ),
                );
              }).toList(),
            ),
          ),
          buildSelectButton(context),
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    final label = widget.isMultiSelection ? 'Languages' : 'Language';
    return AppBar(
      backgroundColor: textColor,
      title: Text('Select $label'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.language),
          onPressed: () => setState(() => isNative = !isNative),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search $label',
        ),
      ),
    );
  }

  Widget buildSelectButton(BuildContext context) {
    final label = widget.isMultiSelection
        ? 'Select ${selectedLanguages.length} Languages'
        : 'Continue';

    return Container(
      padding: EdgeInsets.symmetric(horizontal:100, vertical: 15),
      color: textColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size.fromHeight(40),
          primary: Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(color: black, fontSize: 16),
        ),
        onPressed: submit,
      ),
    );
  }

  void selectLanguage(Language language) {
    if (widget.isMultiSelection) {
      final isSelected = selectedLanguages.contains(language);
      setState(() => isSelected
          ? selectedLanguages.remove(language)
          : selectedLanguages.add(language));
    } else {
      Navigator.pop(context, language);
    }
  }

  void submit() => Navigator.pop(context, selectedLanguages);
}