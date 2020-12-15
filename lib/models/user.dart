import 'package:flutter/material.dart';

class User {
  int id;
  String nome;
  String email;
  String endereco;
  String telefone;
  String cpf;
  Locale dataNascimento;
  String categoria;

  User(this.id, this.nome, this.email, this.endereco, this.telefone, this.cpf,
      this.dataNascimento, this.categoria);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'email': email,
      'endereco': endereco,
      'telefone': telefone,
      'cpf': cpf,
      'data' : dataNascimento,
      'categoria' : categoria
    };
    return map;
  }

  User.FromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    endereco = map['endereco'];
    telefone = map['telefone'];
    cpf = map['cpf'];
    dataNascimento = map['data'];
    categoria = map['categoria'];
  }
}
