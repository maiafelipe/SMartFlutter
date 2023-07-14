import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/form_field_padded.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CompraFormulario extends StatelessWidget {
  const CompraFormulario({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CenterLeftText(AppLocalizations.of(context)!.shopRegister)),
      body: CompraFormularioBody(),
    );
  }
}

class CompraFormularioBody extends StatelessWidget {
  final TextEditingController _controllerFieldDesc = TextEditingController();
  final TextEditingController _controllerFieldLocal = TextEditingController();

  CompraFormularioBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FormFieldPadded(_controllerFieldDesc, AppLocalizations.of(context)!.description, AppLocalizations.of(context)!.descriptionHint,
              icon: Icons.short_text),
          FormFieldPadded(_controllerFieldLocal, AppLocalizations.of(context)!.place, AppLocalizations.of(context)!.placeHint,
              icon: Icons.map_outlined),
          ElevatedButton(
            onPressed: () => _cadastrarCompra(context),
            child: Text(AppLocalizations.of(context)!.register),
          ),
        ],
      ),
    );
  }

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
