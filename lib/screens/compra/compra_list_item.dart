import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:smart/screens/compra/compra_list_view.dart';

class CompraListItem extends StatelessWidget {
  final Compra compra;
  final CompraListViewState? father;
  const CompraListItem(this.compra, {this.father, super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on_outlined),
        title: Text(compra.descricao),
        subtitle: Text(compra.local),
        onLongPress: () {
          if(father!=null){
            father?.apagarCompra(compra);
          }
        },
      ),
    );
  }
}
