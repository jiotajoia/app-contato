import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trabalho_final/controllers/bd.controller.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});
  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  TextEditingController _controller_nome = TextEditingController();
  TextEditingController _controller_desc = TextEditingController();
  TextEditingController _controller_imag = TextEditingController();
  TextEditingController _controller_lati = TextEditingController();
  TextEditingController _controller_long = TextEditingController();

  TextEditingController _controller_nome2 = TextEditingController();
  TextEditingController _controller_desc2 = TextEditingController();
  TextEditingController _controller_imag2 = TextEditingController();
  TextEditingController _controller_lati2 = TextEditingController();
  TextEditingController _controller_long2 = TextEditingController();

  var dados = [];

  obterDados() async {
    Database bd = await abrirBanco();
    dados = await bd.query("contato");

    setState(() {});
  }

  _mostrarCriarPersonagem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adicionar Contato'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _controller_nome,
                  decoration: const InputDecoration(label: Text('nome')),
                ),
                TextFormField(
                  controller: _controller_desc,
                  decoration: const InputDecoration(label: Text('descrição')),
                ),
                TextFormField(
                  controller: _controller_imag,
                  decoration:
                      const InputDecoration(label: Text('url da imagem')),
                ),
                TextFormField(
                  controller: _controller_lati,
                  decoration: const InputDecoration(label: Text('latitude')),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                TextFormField(
                  controller: _controller_long,
                  decoration: const InputDecoration(label: Text('longitude')),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    adicionar(
                        _controller_nome.text,
                        _controller_desc.text,
                        _controller_imag.text,
                        double.parse(_controller_lati.text),
                        double.parse(_controller_long.text));
                    _controller_nome.text = '';
                    _controller_desc.text = '';
                    _controller_imag.text = '';
                    _controller_lati.text = '';
                    _controller_long.text = '';

                    Navigator.of(context).pop();
                  },
                  child: const Text('adicionar')),
            ],
          );
        });
  }

  adicionar(String nome, String desc, String url, double latitude, double longitude) async {
    Database bd = await abrirBanco();

    Map<String, dynamic> reg = {
      "nome": nome,
      'descricao': desc,
      'imagem': url,
      'latitude': latitude,
      'longitude': longitude
    };

    await bd.insert("contato", reg);

    setState(() {});
  }

  deletar(int id) async{
    Database bd = await abrirBanco();
    await bd.delete('contato',where: 'id = ?', whereArgs: [id]);
    setState(() {
    });
  }

  editar(int id,String nome, String desc, String url, double latitude, double longitude) async{
    Database bd = await abrirBanco();

    Map<String, dynamic> novoReg = {
      "nome": nome,
      'descricao': desc,
      'imagem': url,
      'latitude': latitude,
      'longitude': longitude
    };

    await bd.update('contato',novoReg,where: 'id = ?', whereArgs: [id]);
    
    setState(() {
    });
  }

  _mostrarEditarPersonagem(BuildContext context,int id){
    showDialog(context: context,
     builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Editar Contato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller_nome2,
              decoration: const InputDecoration(label: Text('novo nome')),
            ),
            TextFormField(
              controller: _controller_desc2,
              decoration: const InputDecoration(label: Text('nova descrição')),
            ),
            TextFormField(
              controller: _controller_imag2,
              decoration: const InputDecoration(label: Text('nova url da imagem')),
            ),
            TextFormField(
              controller: _controller_lati2,
              decoration: const InputDecoration(label: Text('nova latitude')),
              keyboardType: TextInputType.numberWithOptions(),
              ),
              TextFormField(
                controller: _controller_long2,
                decoration: const InputDecoration(label: Text('nova longitude')),
                keyboardType: TextInputType.numberWithOptions(),
              ),
            
          ],
        ),
        actions: [
          ElevatedButton(onPressed: (){
            editar(id, _controller_nome2.text, _controller_desc2.text, _controller_imag2.text,double.parse(_controller_lati2.text),double.parse(_controller_long2.text));
            _controller_nome2.text = '';
            _controller_desc2.text = '';
            _controller_imag2.text = '';
            _controller_lati2.text = '';
            _controller_long2.text = '';
            Navigator.of(context).pop();
          }, child: const Text('editar')),
        ],
      );
     });
  }

  @override
  Widget build(BuildContext context) {
    obterDados();

    return Scaffold(
        appBar: AppBar(
          title: Text('Contatos'),
          backgroundColor: Colors.yellow,
          actions: [
            IconButton(
                onPressed: () {
                  _mostrarCriarPersonagem(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
            itemCount: dados.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: const Color.fromARGB(255, 219, 152, 235),
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: NetworkImage(
                              dados[index]['imagem'],
                            ),
                            width: 120,
                            height: 120,
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dados[index]['nome'],
                              style: const TextStyle(fontSize: 25)),
                          Text(dados[index]['descricao']),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                   _mostrarEditarPersonagem(context,dados[index]['id']);
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    deletar(dados[index]['id']);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}