import 'package:smart/models/produto.dart';
import 'package:smart/models/oferta.dart';

/// Classe [Compra].
///
/// Representa um [Produto] inserido em uma [Compra].
/// Além da informação do produto, também contém a quantidade de itens daquele [Produto] na compra.
///
/// Autor Felipe.
class ItemCompra {
  /// Contém dos dados do [Produto] que estará na [Compra].
  Produto produto;

  /// Valor [int] com quantidade do produto na compra.
  int quantidade;

  /// Construtor para um item com os parâmetros:
  /// [produto] um [Produto] com os dados do produto.
  /// [quantidade] um [int] com a quantidade.
  ItemCompra(this.produto, this.quantidade);

  /// Calcula o valor total para um item.
  /// Esse valor será a melhor [Oferta] do produto multipliado pela quantidade de item na [Compra].
  double valorTotal() {
    double valor = 0.0;
    Oferta? o = produto.melhorOferta();
    if (o != null) {
      valor = o.preco * quantidade;
    }
    return valor;
  }
}
