import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/form_field_padded.dart';
import 'package:smart/models/dao/compra_dao.dart';

class CompraFormularioEdit extends StatelessWidget {
  final Compra compra;
  const CompraFormularioEdit(this.compra, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CenterLeftText("Cadastro Compra")),
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
          FormFieldPadded(_controllerFieldDesc, "Descrição", "Compra rápida...",
              icon: Icons.short_text),
          FormFieldPadded(_controllerFieldLocal, "Local", "mercantil...",
              icon: Icons.map_outlined),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _apagarCompra(context),
                child: const Text("Apagar"),
              ),
              ElevatedButton(
                onPressed: () => _updateCompra(context),
                child: const Text("Atualizar"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateCompra(BuildContext context) {
    debugPrint("Apertou atualizar.");
    compra.descricao = _controllerFieldDesc.text;
    compra.local = _controllerFieldLocal.text;
    CompraDAO.updateCompra(compra);
    Navigator.pop(context, compra);
  }

  void _apagarCompra(BuildContext context) {
    debugPrint("Apertou apagar.");
    if (compra.id != null) {
      CompraDAO.deleteCompra(compra.id ??= 0);
    }
    Navigator.pop(context, compra);
  }
}
