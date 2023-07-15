import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/form_field_padded.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Classe [CompraFormularioEdit].
///
/// Responsavel por desenhar o formulário para edição de uma compra.
///
/// Contem todos os dados referente a [Compra] que irá editar.
/// Rederiza um [Scaffold] com essas informações e comportamentos necessários.
///
/// Autor Felipe.
class CompraFormularioEdit extends StatelessWidget {
  /// Compra que conterá todas as informações da compra que será editada.
  final Compra compra;

  /// Construtor da classe que recebe a [compra] editada e o parâmetro nomeado opcional [key] para superclasse [StatelessWidget].
  const CompraFormularioEdit(this.compra, {super.key});

  /// Sobrescreve comportamento [build] da superclasse.
  /// Retorna o widget [Scaffold] que conterá todo o formulário.
  /// Para efeito de organização, seu corpo será contruido pela classe [CompraFormularioEditBody].
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CenterLeftText(AppLocalizations.of(context)!.shopUpdate)),
      body: CompraFormularioEditBody(compra),
    );
  }
}

/// Classe [CompraFormularioEditBody].
///
/// Responsavel por desenhar o corpo do formulário para edição de uma [Compra].
///
/// Desenha os campos do formulário e contém seus controlladores.
///
/// Autor Felipe.
class CompraFormularioEditBody extends StatelessWidget {
  /// Controllador para o campo de texto para [Compra.descricao].
  final TextEditingController _controllerFieldDesc = TextEditingController();

  /// Controllador para o campo de texto para [Compra.local].
  final TextEditingController _controllerFieldLocal = TextEditingController();

  /// Compra que conterá todas as informações da compra que será editada.
  final Compra compra;

  /// Construtor da classe que recebe a [compra] editada e o parâmetro nomeado opcional [key] para superclasse [StatelessWidget].
  CompraFormularioEditBody(this.compra, {super.key});

  /// Sobrescreve o comportamento [build] da superclasse.
  /// Cria uma [Column] embalada em um [ScrollView].
  /// Essa coluna terá os campos de texto para permitir a modificação dos dados de compra.
  /// Para efeito de organização, cada campo será contruido pela classe [FormFieldPadded].
  /// Os dados originais da [compra] são carregados no formulário, para permitir ao usuário visualizar o que será alterado.
  /// Também renderiza um botão para permitie salvar a compra criada.
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
    _controllerFieldDesc.text = compra.descricao;
    _controllerFieldLocal.text = compra.local;
    return SingleChildScrollView(
      child: Column(
        children: [
          FormFieldPadded(
              _controllerFieldDesc,
              AppLocalizations.of(context)!.description,
              AppLocalizations.of(context)!.descriptionHint,
              icon: Icons.short_text),
          FormFieldPadded(
              _controllerFieldLocal,
              AppLocalizations.of(context)!.place,
              AppLocalizations.of(context)!.placeHint,
              icon: Icons.map_outlined),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _apagarCompra(context),
                child: Text(AppLocalizations.of(context)!.delete),
              ),
              ElevatedButton(
                onPressed: () => _updateCompra(context),
                child: Text(AppLocalizations.of(context)!.update),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Define o comportamente do botão que atualiza a nova compra.
  /// Deverá utilizar o [CompraDAO] para realizar a persistência dos dados.
  void _updateCompra(BuildContext context) {
    compra.descricao = _controllerFieldDesc.text;
    compra.local = _controllerFieldLocal.text;
    CompraDAO.updateCompra(compra);
    Navigator.pop(context, compra);
  }

  /// Define o comportamente do botão que apaga a nova compra.
  /// Deverá utilizar o [CompraDAO] para realizar a persistência dos dados.
  void _apagarCompra(BuildContext context) {
    if (compra.id != null) {
      CompraDAO.deleteCompra(compra.id ??= 0);
    }
    compra.status = null;
    Navigator.pop(context, compra);
  }
}
