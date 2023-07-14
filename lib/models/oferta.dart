class Oferta{
  int quantidade;
  double tamanho;
  double preco;

  Oferta(this.quantidade, this.tamanho, this.preco);

  double calcCoef(){
    return preco/(tamanho*quantidade);
  }
}