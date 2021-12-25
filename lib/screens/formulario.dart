import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:formulario/models/produto.dart';

class Formulario extends StatelessWidget {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidade = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrando produto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controladorNome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorQuantidade,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  inputFormatters: [
                    TextInputMask(
                      mask: '\R!\$! !9+,99',
                      placeholder: '0',
                      maxPlaceHolders: 3,
                      reverse: true,
                    )
                  ],
                  keyboardType: TextInputType.number,
                  controller: _controladorValor,
                  decoration: InputDecoration(labelText: 'Valor'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text('Cadastrar'),
                  onPressed: () => _criaProduto(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _criaProduto(BuildContext context) {
    var nome = _controladorNome.text;
    var quantidade = int.tryParse(_controladorQuantidade.text);
    var valorEmTexto = _controladorValor.text;
    String valorFormatado = formataValor(valorEmTexto);
    var valor = double.tryParse(valorFormatado);

    if (nome != null && quantidade != null && valor != null) {
      var produto = Produto(nome, quantidade, valor);
      Navigator.pop(context, produto);
    }
  }

  String formataValor(String valorEmTexto) {
    var valorReplace =
        valorEmTexto
            .replaceAll('\R', '')
            .replaceAll('\$', '')
            .replaceAll(',', '.')
            .trim();
    return valorReplace;
  }
}
