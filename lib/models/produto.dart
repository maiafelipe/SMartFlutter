import 'package:smart/models/oferta.dart';

/// Classe [Produto].
///
/// Representa um produto para a aplicação.
/// O produto terá uma descrição e uma lista com todas as ofertas para esse produto.
/// 
/// Além de armazenar as informações, essa classe calcula a melhor oferta para o produto. 
///
/// Autor Felipe.
class Produto{
  /// Valor [String] com a descrição para o produto.
  String descricao;

  /// Uma [List] para armazenar todas as [Oferta] do produto. Já é inicializada vazia.
  List<Oferta> ofertas = [];

  /// Construtor para um Produto com o parâmetro:
  /// [descricao] uma [String] com a descrição.
  Produto(this.descricao);

  /// Descobre e retorna a melhor oferta da lista no produto.
  /// A lista será percorrida e a [Oferta] com o melhor coeficiente será selecionada.
  /// Caso não haja nada na lista, retorna [Null].
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