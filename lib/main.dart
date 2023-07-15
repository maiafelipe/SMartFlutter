import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart/screens/compra/compra_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  /// Garante a instanciação de biblioteca de código nativo.
  WidgetsFlutterBinding.ensureInitialized();

  /// Inicializa o App usando chamada run do Flutter.
  runApp(const SmartApp());
}

/// Classe [SmartApp].
///
/// Contem o Widget Raiz da aplicação.
///
/// Cria o Widget [MaterialApp] com suas definições de tema e de localização.
///
/// Define a home: [CompraListView].
///
/// Autor: Felipe.
class SmartApp extends StatelessWidget {
  /// Construtor da classe com parâmetro nomeado opcional [key] para superclasse [StatelessWidget].
  const SmartApp({super.key});

  /// Sobrescreve comportamento [build] da superclasse.
  /// Retorna o widget [MaterialApp] que será raiz da aplicação.
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 16, 40, 23)),
        useMaterial3: true,
      ),
      home: CompraListView(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'), // Portuguese
        Locale('es'), // Spanish
        Locale('en'), // English
      ],
    );
  }
}
