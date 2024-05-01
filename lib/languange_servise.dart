import 'package:shared_preferences/shared_preferences.dart';

enum Language { uz, en, ru }

class LanguageService {
  static Language _language = Language.en;

  static Language get getLanguage => _language;

  static void setLanguage(Language language) async {
    _language = language;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language.toString());
  }

  static Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('language');
    if (lang != null) {
      _language = Language.values.firstWhere(
          (element) => element.toString() == lang,
          orElse: () => Language.en);
    }
  }

  static const String _kLanguageCodeKey = 'language_code';

  // Function to save the language code to shared preferences
  static Future<void> _saveLanguageToPrefs(Language language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kLanguageCodeKey, language.index);
  }

  // Function to load the language code from shared preferences
  static Future<void> _loadLanguageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int languageIndex = prefs.getInt(_kLanguageCodeKey) ?? 0;
    _language = Language.values[languageIndex];
  }

  static Future<void> initLanguageService() async {
    await _loadLanguageFromPrefs();
  }
}

extension TranslateString on String {
  String get tr {
    switch (LanguageService.getLanguage) {
      case Language.uz:
        {
          return uz[this] ?? this;
        }
      case Language.en:
        {
          return en[this] ?? this;
        }
      case Language.ru:
        {
          return ru[this] ?? this;
        }
    }
  }
}

const Map<String, String> en = {
  'Title': 'Welcome to our app!',
};

const Map<String, String> ru = {'Title': 'Добро пожаловать в наше приложение!'};

const Map<String, String> uz = {'Title': 'Bizning dasturimizga xush kelibsiz!'};
