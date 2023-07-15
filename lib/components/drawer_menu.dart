import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Classe [DrawerMenu].
///
/// Componente reutilizavel para o menu de gaveta da aplicação.
///
/// Contem todos os dados e componentes desse menu.
///
/// Autor Felipe.
class DrawerMenu extends StatelessWidget {
  /// Construtor da classe com o parâmetro nomeado opcional [key] para superclasse [StatelessWidget].
  const DrawerMenu({super.key});

  /// Sobrescreve comportamento [build] da superclasse.
  /// Retorna o widget [Drawer] embalado em um [SizedBox].
  /// Contem todos os componentes da gaveta.
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 131, 88),
              ),
              child: Text(
                AppLocalizations.of(context)!.appName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_basket),
              title: Text(AppLocalizations.of(context)!.shops),
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Text(AppLocalizations.of(context)!.products),
            ),
          ],
        ),
      ),
    );
  }
}
