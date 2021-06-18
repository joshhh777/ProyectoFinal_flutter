import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/servicios/authentication_servicios/auth_services.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina de Inicio"),
        actions: [
          IconButton(
            onPressed: () async => await loginProvider.logout(), 
            icon: Icon(Icons.exit_to_app)
            ),
        ],
      ),
    );
  }
}