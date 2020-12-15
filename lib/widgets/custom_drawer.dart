
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController  pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          // BoxDecoration permite o uso de cores gradiente
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                begin: Alignment.center,
                end: Alignment.bottomCenter),
          ),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 8.0,
                ),
                padding: EdgeInsets.only(
                    left: 0.0, top: 16.0, right: 16.0, bottom: 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Livraria",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Olá, ${!model.isLoadingIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoadingIn() ?
                                    "Entre ou cadastre-se > " : "Sair",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    if(!model.isLoadingIn())
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                    else {
                                      model.signOut();
                                    }
                                  },
                                )
                              ],
                            );
                          },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController,0),
              DrawerTile(Icons.list, "Categoria",pageController,1),
              DrawerTile(Icons.playlist_add_check, "Meus empréstimos",pageController,2),

            ],
          )
        ],
      ),
    );
  }
}

