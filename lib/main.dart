import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart/screens/compra/compra_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  runApp(
    const SmartApp(),
  );
}

class SmartApp extends StatelessWidget {
  const SmartApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 16, 40, 23)),
        useMaterial3: true,
      ),
      home: CompraListView(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'), // Portuguese
        Locale('es'), // Spanish
        Locale('en'), // English
      ],
      locale: const Locale('pt'),
    );
  }
}
