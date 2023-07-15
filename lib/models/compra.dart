import 'package:flutter/foundation.dart';
import 'package:smart/models/item_compra.dart';

/// Enum com os possiveis estados para uma compra.
enum CompraStatus {
  active,
  disable;
}

/// Classe [Compra].
///
/// Representa um modelo de compra para a aplicação.
///
/// Autor Felipe.
class Compra {
  /// Identificador opcional para a compra. Apenas necessário para banco.
  int? id;

  /// Descrição de uma compra.
  String descricao;

  /// Local para uma compra.
  String local;

  /// Status da compra, de acordo com o enum [CompraStatus].
  CompraStatus? status;

  /// Lista de itens de uma compra. Inicializa vazio.
  List<ItemCompra> lista = [];

  /// Construtor para uma compra com os parâmetros:
  /// [descricao] uma [String] com a descrição.
  /// [local] uma [String] com o local.
  /// [id] um [int] com o identificador, é opcional e nomeado.
  /// [status] um [CompraStatus] com o status da compra.
  Compra(this.descricao, this.local, {this.id, this.status});
  
  /// Calcula o valor total de uma compra.
  /// Percorre toda a lista de itens, somando o valor total de cada item.
  /// Retorna um [double] como o valor.
  double totalCompra() {
    double valor = 0.0;
    for (ItemCompra i in lista) {
      valor += i.valorTotal();
    }
    return valor;
  }

  /// Realiza o mapamento da compra para um [Map]
  /// Necessário para facilitar a persistência em banco.
  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'local': local,
      'status': describeEnum(status ?? CompraStatus.active),
    };
  }

  /// Sobrescrita do método para converter uma compra em [String].
  @override
  String toString() {
    return 'Compra{id: $id, descricao: $descricao, local: $local, status: $status}';
  }
}
