import 'package:smart/models/produto.dart';
import 'package:smart/models/oferta.dart';

class ItemCompra{
  Produto produto;
  int quantidade;

  ItemCompra(this.produto, this.quantidade);

  double valorTotal(){
    double valor = 0.0;
    Oferta? o = produto.melhorOferta();
    if(o != null){
      valor = o.preco*quantidade;
    }
    return valor;
  }
}