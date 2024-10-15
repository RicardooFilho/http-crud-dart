import 'package:flutter/material.dart';
import 'bank-component.dart';

class BankerFormComponent extends StatefulWidget {
  const BankerFormComponent({super.key});

  @override
  _BankerFormComponentState createState() => _BankerFormComponentState();
}

class _BankerFormComponentState extends State<BankerFormComponent> {
  final _nameController = TextEditingController();
  final _saldoController = TextEditingController();
  final BankAccountAPI _api = BankAccountAPI();

  void _submitForm() async {
    String name = _nameController.text;
    String saldo = _saldoController.text;

    if (name.isNotEmpty && saldo.isNotEmpty) {
      String body = '{"name": "$name", "saldo": $saldo}';
      await _api.save(body);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Bancário')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _saldoController,
                decoration: InputDecoration(
                  labelText: 'Saldo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green, // Cor de fundo do botão
                  foregroundColor:
                      Colors.white, // Cor do texto do botão (branca)
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
