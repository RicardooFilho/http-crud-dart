import 'package:flutter/material.dart';
import 'bank-component.dart';
import 'dart:convert';
import 'banker-form-component.dart';
import 'package:intl/intl.dart';

class BankerListComponent extends StatefulWidget {
  const BankerListComponent({super.key});

  @override
  _BankerListComponentState createState() => _BankerListComponentState();
}

class _BankerListComponentState extends State<BankerListComponent> {
  final BankAccountAPI _api = BankAccountAPI();
  List<dynamic> _clients = [];

  @override
  void initState() {
    super.initState();
    _getClients();
  }

  void _getClients() async {
    String response = await _api.findAll();
    setState(() {
      _clients = jsonDecode(response);
    });
  }

  void _deleteClient(String idBanker) async {
    await _api.deleteById(idBanker);
    _getClients();
  }

  void _editClient(String idBanker, String existingName, String existingSaldo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BankerFormComponent(
          clientId: idBanker,
          existingName: existingName,
          existingSaldo: existingSaldo,
        ),
      ),
    ).then((_) => _getClients());
  }

  String _formatCurrency(double saldo) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(saldo);
  }

  Color _getSaldoColor(double saldo) {
    if (saldo < 0) {
      return Colors.red;
    } else if (saldo > 0) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Bancários')),
      body: ListView.builder(
        itemCount: _clients.length,
        itemBuilder: (context, index) {
          var client = _clients[index];
          var saldo = double.parse(client['saldo'].toString());

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.account_circle, size: 40, color: Colors.blueAccent),
                title: Text(
                  client['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Saldo: ${_formatCurrency(saldo)}',
                  style: TextStyle(
                    color: _getSaldoColor(saldo),
                    fontSize: 16,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editClient(client['id'], client['name'], client['saldo'].toString()),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteClient(client['id']),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BankerFormComponent()),
          ).then((_) => _getClients());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
