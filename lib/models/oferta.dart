/// Classe [Oferta].
///
/// Representa uma oferta de um Produto.
/// Uma oferta será um preço associado a uma quantidade e tamanho.
/// Produtos podem conter preços diferentes, dependendo do seu tamanho o quantidade (atacado).
/// 
/// Além de armazenar as informações de preço, essa classe calcula um coeficiente que permite comparar ofertas. 
///
/// Autor Felipe.
class Oferta{
  /// Valor [int] com quantidade para um produto em uma oferta.
  int quantidade;

  /// Valor [double] com tamanho para um produto em uma oferta.
  double tamanho;

  /// Valor [double] com preço para um produto em uma oferta.
  double preco;

  /// Construtor para uma oferta com os parâmetros:
  /// [quantidade] um [int] com a quantidade.
  /// [tamanho] um [double] com o tamanho.
  /// [preco] um [double] com o preço.
  Oferta(this.quantidade, this.tamanho, this.preco);

  /// Calcula o coeficiente de uma oferta.
  /// Esse valor será o preço dividido pelo tamanho*quantidade.
  double calcCoef(){
    return preco/(tamanho*quantidade);
  }
}