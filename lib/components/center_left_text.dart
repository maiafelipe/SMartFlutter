import 'package:flutter/material.dart';

/// Classe [CenterLeftText].
///
/// Componente reutilizavel que padroniza a renderização do texto
/// em determinadas partes da aplicação.
///
/// Contem todos os dados referente ao alinhamento do texto.
///
/// Autor Felipe.
class CenterLeftText extends StatelessWidget {
  /// Texto que será renderizado.
  final String label;

  /// Construtor da classe que recebe a [label] e o parâmetro nomeado opcional [key] para superclasse [StatelessWidget].
  const CenterLeftText(this.label, {super.key});

  /// Sobrescreve comportamento [build] da superclasse.
  /// Retorna o widget [Align] que conterá o texto corretamento alinhado.
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(label),
    );
  }
}
