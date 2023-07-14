import 'package:flutter/material.dart';
import 'package:smart/screens/compra/compra_list_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  runApp(
    SmartApp(),
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
    );
  }
}
