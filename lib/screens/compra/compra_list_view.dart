import 'package:flutter/material.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:smart/screens/compra/compra_formulario.dart';
import 'package:smart/screens/compra/compra_formulario_edit.dart';
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
    loadDataListaCompras();
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
    final Future future = Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CompraFormulario();
      }),
    );
    future.then((compraRecebida) {
      if (compraRecebida != null) {
        widget._compras.add(compraRecebida);
        reloadListaCompras();
      }
    });
  }

  void loadDataListaCompras() {
    widget._compras.clear();
    Future<List<Compra>> lista = CompraDAO.selectAllCompras();
    lista.then((lista) {
      setState(() {
        for (Compra compra in lista) {
          widget._compras.add(compra);
        }
      });
    });
  }

  void reloadListaCompras() {
    setState(() {
      debugPrint("Hot reloading a lista ${widget._compras.length}.");
    });
  }

  void editarCompra(Compra compra) {
    if (compra.id != null) {
      final Future future = Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return CompraFormularioEdit(compra);
        }),
      );
      future.then((value) {
        if (value.status != null) {
          for (compra in widget._compras) {
            if (compra.id == value.id) {
              compra = value;
            }
          }
        } else {
          widget._compras.removeWhere((element) {
            return element.id == value.id;
          });
        }
        reloadListaCompras();
      });
    }
  }

  void toggleStatusCompra(Compra compra) {
    if (compra.id != null) {
      int id = compra.id ?? 0;
      if (compra.status == CompraStatus.active) {
        compra.status = CompraStatus.disable;
      } else {
        compra.status = CompraStatus.active;
      }
      CompraDAO.updateCompra(compra);
    }
    for (Compra c in widget._compras) {
      if (c.id == compra.id) {
        c.status = compra.status;
      }
    }
    reloadListaCompras();
    //loadDataListaCompras();
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
