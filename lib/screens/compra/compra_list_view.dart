import 'package:flutter/material.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:smart/screens/compra/compra_formulario.dart';
import 'package:smart/screens/compra/compra_list_item.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/drawer_menu.dart';

class CompraListView extends StatefulWidget {
  final List<Compra> _compras = [];
  CompraListView({super.key});
  @override
  State<StatefulWidget> createState() => CompraListViewState();
}

class CompraListViewState extends State<CompraListView> {
  @override
  void initState() {
    loadListaCompras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CenterLeftText("Compras")),
      drawer: const DrawerMenu(),
      body: ListView.builder(
        itemCount: widget._compras.length,
        itemBuilder: (context, indice) {
          final Compra lista = widget._compras[indice];
          return CompraListItem(lista, father: this);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          callNewCompraForm(context);
        },
      ),
    );
  }

  void callNewCompraForm(BuildContext context) {
    debugPrint("Abrindo Formulário.");
    final Future future = Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CompraFormulario();
      }),
    );
    future.then((listaRecebida) {
      if (listaRecebida != null) {
        loadListaCompras();
      }
    });
  }

  void loadListaCompras() {
    widget._compras.clear();
    Future<List<Compra>> lista = CompraDAO.selectAllCompras();
    lista.then((lista) {
      setState(() {
        for (Compra compra in lista) {
          debugPrint("$compra");
          widget._compras.add(compra);
        }
      });
    });
  }

  void apagarCompra(Compra compra){
    if(compra.id != null){
      int id = compra.id ?? 0;
      CompraDAO.deleteCompra(id);
    }
    loadListaCompras();
    debugPrint("Apagou e setou o state.");
  }

  void testeDatabase(BuildContext context) {
    debugPrint("Testando o Banco de dados.");
    Future<int> id = CompraDAO.insertCompra(Compra("Teste a", "local"));
    id.then((value) => debugPrint("Chegou $value"));
    Future<List<Compra>> lista = CompraDAO.selectAllCompras();
    lista.then((lista) {
      for (Compra compra in lista) {
        debugPrint("$compra");
      }
    });
  }
}
