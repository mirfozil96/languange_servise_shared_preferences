import 'package:flutter/material.dart';
import 'languange_servise.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageService.initLanguageService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo'.tr,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'.tr),
        actions: [
          PopupMenuButton<Language>(
            onSelected: (Language result) {
              setState(() {
                LanguageService.setLanguage(result);
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
              const PopupMenuItem<Language>(
                value: Language.uz,
                child: Text('O\'zbekcha'),
              ),
              const PopupMenuItem<Language>(
                value: Language.en,
                child: Text('English'),
              ),
              const PopupMenuItem<Language>(
                value: Language.ru,
                child: Text('Русский'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
