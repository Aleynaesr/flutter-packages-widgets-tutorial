import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:single_multiselection_listview/model/language.dart';
import 'package:single_multiselection_listview/page/language_page.dart';
import 'package:single_multiselection_listview/provider/language_provider.dart';
import 'package:single_multiselection_listview/thema/constant.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Select Languages';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldColor,
        primaryColor: scaffoldColor,
      ),
      home: MainPage(),
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Language? language;
  List<Language> languages = [];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Settings", style: TextStyle(color: white ),),
      backgroundColor: textColor,
    ),
    backgroundColor: Theme.of(context).primaryColor,
    body: Padding(
      padding: const EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSingleLanguage(),
          const SizedBox(height: padding),
          buildMultipleLanguage(),
        ],
      ),
    ),
  );

  Widget buildSingleLanguage() {
    final onTap = () async {
      final language = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LanguagePage()),
      );

      if (language == null) return;

      setState(() => this.language = language);
    };

    return buildLanguagePicker(
      title: 'Language I speak',
      child:language == null
          ? buildListTile(title: 'No Language', onTap: onTap)
          : buildListTile(
        title: language!.name,
        onTap: onTap,
      ),
    );
  }

  Widget buildMultipleLanguage() {
    final languagesText = languages.map((language) => language.name).join(', ');
    // ignore: prefer_function_declarations_over_variables
    final onTap = () async {
      final languages = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LanguagePage(
              isMultiSelection: true,
              languages: List.of(this.languages),
            )),
      );

      if (languages == null) return;

      setState(() => this.languages = languages);
    };

    return buildLanguagePicker(
      title: "Languages I'm learning",
      child: languages.isEmpty
          ? buildListTile(title: 'No Languages', onTap: onTap)
          : buildListTile(title: languagesText, onTap: onTap),
    );
  }

  Widget buildListTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: black, fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_drop_down, color: textColor),
    );
  }

  Widget buildLanguagePicker({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color:textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}