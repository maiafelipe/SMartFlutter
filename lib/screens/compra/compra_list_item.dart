import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/screens/compra/compra_list_view.dart';

/// Classe [CompraListItem].
///
/// Responsavel por desenhar cada item de compra da lista presente em [CompraListView].
///
/// Contem todos os dados referente a [Compra] que irá apresentar.
/// Rederiza um [Card] com essas informações e comportamentos necessários.
///
/// Autor Felipe.
class CompraListItem extends StatelessWidget {
  /// Dados da compra que será renderizada.
  final Compra compra;

  /// Referencia para a classe pai. Possibilita chamar operações de [CompraListViewState].
  final CompraListViewState? father;

  /// Construtor da classe com parâmetro [compra] que será obrigatório.
  /// Também contem os parâmetros nomeados opcionais [father] e a [key] da superclasse.
  const CompraListItem(this.compra, {this.father, super.key});

  /// Sobrescreve comportamento [build] da superclasse.
  /// Retorna o widget [Card] que será utilizada para rendereizar cada item na lista de compras.
  /// Define suas devidas configurações.
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
              father?.callEditarCompraForm(compra);
            }
          },
        ),
      ),
    );
  }
}
