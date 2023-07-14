import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/screens/compra/compra_list_view.dart';

class CompraListItem extends StatelessWidget {
  final Compra compra;
  final CompraListViewState? father;
  const CompraListItem(this.compra, {this.father, super.key});
  @override
  Widget build(BuildContext context) {
    CompraStatus status = compra.status ?? CompraStatus.active;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on_outlined),
        title: Text(
          compra.descricao,
          style: TextStyle(
            decoration: (status == CompraStatus.disable
                ? TextDecoration.lineThrough
                : null),
          ),
        ),
        subtitle: Text(
          compra.local,
          style: TextStyle(
            decoration: (status == CompraStatus.disable
                ? TextDecoration.lineThrough
                : null),
          ),
        ),
        onTap: () {
          if (father != null) {
            father?.toggleStatusCompra(compra);
          }
        },
        trailing: TextButton(
          child: const Icon(Icons.more_vert),
          onPressed: () {
            if (father != null) {
              father?.editarCompra(compra);
            }
          },
        ),
      ),
    );
  }
}
