import 'package:flutter/material.dart';
import 'banker-form-component.dart';
import 'banker-list-component.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação de Conta Bancária',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BankerListComponent(),
        '/form': (context) => BankerFormComponent(),
      },
    );
  }
}
