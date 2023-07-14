import 'package:flutter/foundation.dart';
import 'package:smart/models/item_compra.dart';

enum CompraStatus {
  active,
  disable;
}

class Compra {
  int? id;
  String descricao;
  String local;
  CompraStatus? status;

  List<ItemCompra> lista = [];

  Compra(this.descricao, this.local, {this.id, this.status});

  double totalCompra() {
    double valor = 0.0;
    for (ItemCompra i in lista) {
      valor += i.valorTotal();
    }
    return valor;
  }

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'local': local,
      'status': describeEnum(status??CompraStatus.active),
    };
  }

  @override
  String toString() {
    return 'Compra{id: $id, descricao: $descricao, local: $local, status: $status}';
  }
}
