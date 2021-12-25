import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formulario/models/produto.dart';
import 'package:formulario/screens/formulario.dart';

class Lista extends StatefulWidget {
  final List<Produto> _produtos = List();

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de produtos'),
      ),
      body: ListView.builder(
        itemCount: widget._produtos.length,
        itemBuilder: (context, index) {
          var produto = widget._produtos[index];
          return ItemProduto(produto);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Formulario();
          })).then((produtoRecebido) => _atualiza(produtoRecebido));
        },
      ),
    );
  }

  void _atualiza(produtoRecebido) {
    if (produtoRecebido != null) {
      setState(() {
        widget._produtos.add(produtoRecebido);
      });
    }
  }
}

class ItemProduto extends StatelessWidget {
  final Produto _produto;

  const ItemProduto(this._produto);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _produto.getCurrency(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(_produto.quantidade.toString()),
        leading: Text(_produto.nome),
      ),
    );
  }
}
