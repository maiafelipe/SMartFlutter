import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/form_field_padded.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Classe [CompraFormularioCreate].
///
/// Responsavel por desenhar o formulário para criação de uma nova compra.
///
/// Rederiza um [Scaffold] com o formulário para registrar a [Compra].
///
/// Autor Felipe.
class CompraFormularioCreate extends StatelessWidget {
  /// Construtor da classe com o parâmetro nomeado opcional [key] para superclasse [StatelessWidget].
  const CompraFormularioCreate({super.key});

  /// Sobrescreve comportamento [build] da superclasse.
  /// Retorna o widget [Scaffold] que conterá todo o formulário.
  /// Para efeito de organização, seu corpo será contruido pela classe [CompraFormularioCreateBody].
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CenterLeftText(AppLocalizations.of(context)!.shopRegister)),
      body: CompraFormularioCreateBody(),
    );
  }
}

/// Classe [CompraFormularioCreateBody].
///
/// Responsavel por desenhar o corpo do formulário para criação de uma nova [Compra].
///
/// Desenha os campos do formulário e contém seus controlladores.
///
/// Autor Felipe.
class CompraFormularioCreateBody extends StatelessWidget {
  /// Controllador para o campo de texto para [Compra.descricao].
  final TextEditingController _controllerFieldDesc = TextEditingController();

  /// Controllador para o campo de texto para [Compra.local].
  final TextEditingController _controllerFieldLocal = TextEditingController();

  /// Construtor da classe com o parâmetro nomeado opcional [key] para superclasse [StatelessWidget].
  CompraFormularioCreateBody({super.key});

  /// Sobrescreve o comportamento [build] da superclasse.
  /// Cria uma [Column] embalada em um [ScrollView].
  /// Essa coluna terá os campos de texto para permitir inserção dos dados de compra.
  /// Para efeito de organização, cada campo será contruido pela classe [FormFieldPadded].
  /// Também renderiza um botão para permitie salvar a compra criada.
  /// Define suas devidas configurações.
  @override
  Widget build(BuildContext context) {
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
          ElevatedButton(
            onPressed: () => _cadastrarCompra(context),
            child: Text(AppLocalizations.of(context)!.register),
          ),
        ],
      ),
    );
  }

  /// Define o comportamente do botão que salva a nova compra.
  /// Deverá utilizar o [CompraDAO] para realizar a persistência dos dados.
  void _cadastrarCompra(BuildContext context) {
    Compra compra = Compra(
      _controllerFieldDesc.text,
      _controllerFieldLocal.text,
      status: CompraStatus.active,
    );
    Future<int> id = CompraDAO.insertCompra(compra);
    id.then((value) {
      compra.id = value;
      Navigator.pop(context, compra);
    });
  }
}
