import 'package:flutter/material.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/form_field_padded.dart';
import 'package:smart/models/dao/compra_dao.dart';

class CompraFormulario extends StatelessWidget {
  const CompraFormulario({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CenterLeftText("Cadastro Compra")),
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
          FormFieldPadded(_controllerFieldDesc, "Descrição", "Compra rápida...",
              icon: Icons.short_text),
          FormFieldPadded(_controllerFieldLocal, "Local", "mercantil...",
              icon: Icons.map_outlined),
          ElevatedButton(
            onPressed: () => _cadastrarCompra(context),
            child: const Text("Cadastrar"),
          ),
        ],
      ),
    );
  }

  void _cadastrarCompra(BuildContext context) {
    debugPrint("Apertou cadastro.");
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
