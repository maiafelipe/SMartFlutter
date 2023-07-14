import 'package:smart/models/oferta.dart';

class Produto{
  String descricao;
  List<Oferta> ofertas = [];

  Produto(this.descricao);

  Oferta? melhorOferta(){
    Oferta? melhor;
    double coef = double.infinity;
    for (Oferta o in ofertas) {
      if(o.calcCoef() < coef){
        coef = o.calcCoef();
        melhor = o;
      }
    }
    return melhor;
  }
}