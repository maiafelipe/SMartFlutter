import 'package:flutter/material.dart';
import 'package:smart/models/dao/compra_dao.dart';
import 'package:smart/screens/compra/compra_formulario.dart';
import 'package:smart/screens/compra/compra_formulario_edit.dart';
import 'package:smart/screens/compra/compra_list_item.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/components/center_left_text.dart';
import 'package:smart/components/drawer_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Classe CompraListView.
///
/// Tela responsável pode visualização
/// da lista de compras.
///
/// Stateful: permite mudança de estado.
/// Seu componentes não são estáticos
/// podendo variar programaticamente.
///
/// Cada estado dessa tela deve ser
/// descrito de acordo com a classe
/// CompraListViewState.
///
/// @see CompraListViewState
/// @author Felipe
class CompraListView extends StatefulWidget {
  /// Armazena a lista com o modelo de compra.
  final List<Compra> _compras = [];

  /// Construtor da classe com parâmetro
  /// nomeado opcional para superclasse.
  CompraListView({super.key});

  /// Define a classe que será chamada
  /// a cada novo estado da tela.
  @override
  State<StatefulWidget> createState() => CompraListViewState();
}

/// Classe CompraListViewState.
///
/// Descreve a tela para cada novo
/// estado que pode assumir.
///
/// Desenha o widget CompraListView
/// de acordo com a configuração da
/// List _compras.
///
/// @author Felipe
class CompraListViewState extends State<CompraListView> {
  /// Realiza a configuração inicial do widget
  /// é chamada apenas para o State inicial.
  @override
  void initState() {
    loadDataListaCompras();
    super.initState();
  }

  /// Constrio todos os componente da tela.
  /// Organiza tudo em um Scaffold.
  /// Adiciona AppBar e DrawerMenu.
  /// Cria um ListView com um item
  /// para cada elemento da lista _compras
  /// do _widget (classe stateful).
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: CenterLeftText(AppLocalizations.of(context)!.shops)),
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

  /// Método callNewCompraForm.
  /// Chamado quando o botão de uma nova
  /// compra é apertado.
  /// Deve criar a rota para a tela
  /// com o formulário para cadastrar uma
  /// nova compra.
  void callNewCompraForm(BuildContext context) {
    final Future future = Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const CompraFormulario();
      }),
    );
    future.then((compraRecebida) {
      if (compraRecebida != null) {
        widget._compras.add(compraRecebida);
        reloadListaCompras();
      }
    });
  }

  /// Método loadDataListaCompras.
  /// Carregamento completo da lista
  /// _compras que está no _widget.
  /// A lista é completamente recriada.
  /// Sugestão: mover manipulação
  /// da lista para a classe Stateful.
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

  /// Método reloadListaCompras.
  /// Apenas chama o redesenho
  /// do estado. Quando ocorre
  /// qualquer mudança na lista,
  /// esse método deve ser chamado
  /// em seguida.
  void reloadListaCompras() {
    setState(() {
      debugPrint("Hot reloading a lista ${widget._compras.length}.");
    });
  }

  /// Método editarCompra.
  /// Chamado quando o botão de edição
  /// de uma compra é pressionado.
  /// Deve criar a rota para chamar
  /// a tela de edição da compra, informando
  /// qual a compra será editada.
  /// Quando recebe o resultado da tela, deve
  /// solicitar o redesenho para apresentar
  /// qualquer alteração.
  /// @arg compra: qual compra chamou.
  void editarCompra(Compra compra) {
    if (compra.id != null) {
      final Future future = Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return CompraFormularioEdit(compra);
        }),
      );
      future.then((value) {
        if (value != null) {
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
        }
      });
    }
  }

  /// Método toggleStatusCompra.
  /// Chamado quando o status de uma compra
  /// é alterado.
  /// Deve modificar o valor do statos da
  /// compra na lista e solicitar o redesenho da
  /// tela.
  /// @arg compra: qual compra chamou.
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
  }
}
