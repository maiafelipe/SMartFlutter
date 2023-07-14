import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
  });

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