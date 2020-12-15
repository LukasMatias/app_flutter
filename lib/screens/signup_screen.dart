import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _celController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _categoriaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text.isEmpty) return "Nome inválido";
                    }),
                TextFormField(
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido";
                    }),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 8)
                      return "Senha inválida";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _enderecoController,
                    decoration: InputDecoration(hintText: "Endereço"),
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválido";
                    }),
                TextFormField(
                    controller: _celController,
                    decoration: InputDecoration(hintText: "Celular"),
                    keyboardType: TextInputType.phone,
                    validator: (text) {
                      if (text.isEmpty) return "Número inválido";
                    }),
                TextFormField(
                    controller: _cpfController,
                    decoration: InputDecoration(hintText: "CPF"),
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text.isEmpty) return "CPF inválido";
                    }),
                TextFormField(
                    controller: _dataNascimentoController,
                    decoration: InputDecoration(hintText: "Data de Nascimento"),
                    keyboardType: TextInputType.datetime,
                    validator: (text) {
                      if (text.isEmpty) return "Data inválida";
                    }),
                TextFormField(
                    controller: _categoriaController,
                    decoration: InputDecoration(hintText: "Categoria"),
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text.isEmpty) return "Categoria inválida";
                    }),
                RaisedButton(
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 10.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController,
                          "address": _enderecoController,
                          "cel": _celController,
                          "cpf": _cpfController,
                          "dataNascimento": _dataNascimentoController,
                          "categoria": _categoriaController,
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSucess: _onSuccess,
                            onFail: _onFail);
                      }
                    }),
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text("Usuário cadastrado com sucesso!"),backgroundColor: Theme.of(context).primaryColor, duration: Duration(seconds: 2),)
  );
  Future.delayed(Duration(seconds: 2)).then((_){
    Navigator.of(context).pop();
  });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao cadastrar!"),backgroundColor: Colors.redAccent, duration: Duration(seconds: 2),)
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }
}
