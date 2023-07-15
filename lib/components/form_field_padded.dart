import 'package:flutter/material.dart';

/// Classe [FormFieldPadded].
///
/// Componente reutilizavel para os campos de formulários da aplicação.
///
/// Contem todos os dados e componentes desses formulários.
///
/// Autor Felipe.
class FormFieldPadded extends StatelessWidget {
  /// Controllador para o campo do formulário, permite coletar a informação quando necessário.
  final TextEditingController controllerField;

  /// Rótulo do campo de texto.
  final String label;

  /// Dica que será exibida no campo de texto.
  final String hint;

  /// Icone opcional que será exibido junto ao campo. 
  final IconData? icon;

  /// Construtor para o campo de texto que recebe:
  /// [controllerField] controllador necessário para o campo.
  /// [label] rótulo necessário para o campo.
  /// [hint] dica necessária para o campo.
  /// [icon] icone opcional como parâmetro nomeado.
  /// [key] parâmetro nomeado e opcional para a super classe.
  const FormFieldPadded(
    this.controllerField,
    this.label,
    this.hint, {
    this.icon,
    super.key,
  });

  /// Sobrescreve comportamento [build] da superclasse.
  /// Retorna o widget [TextField] embalado em um [Padding].
  /// Contem todos os componentes para o campo de texto.
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controllerField,
        style: const TextStyle(fontSize: 24.0),
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}
