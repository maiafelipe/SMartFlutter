import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/form_field_padded.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompraFormularioEdit extends StatelessWidget {
  final Compra compra;
  const CompraFormularioEdit(this.compra, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CenterLeftText(AppLocalizations.of(context)!.shopUpdate)),
      body: CompraFormularioEditBody(compra),
    );
  }
}

class CompraFormularioEditBody extends StatelessWidget {
  final TextEditingController _controllerFieldDesc = TextEditingController();
  final TextEditingController _controllerFieldLocal = TextEditingController();
  final Compra compra;
  CompraFormularioEditBody(this.compra, {super.key});

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

  void _updateCompra(BuildContext context) {
    compra.descricao = _controllerFieldDesc.text;
    compra.local = _controllerFieldLocal.text;
    CompraDAO.updateCompra(compra);
    Navigator.pop(context, compra);
  }

  void _apagarCompra(BuildContext context) {
    if (compra.id != null) {
      CompraDAO.deleteCompra(compra.id ??= 0);
    }
    compra.status = null;
    Navigator.pop(context, compra);
  }
}
