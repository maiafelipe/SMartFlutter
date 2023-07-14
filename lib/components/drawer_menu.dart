import 'package:flutter/material.dart';

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
          
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 131, 88),
              ),
              child: Text(
                'SMart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Compras'),
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Produtos'),
            ),
          ],
        ),
      ),
    );
  }
}