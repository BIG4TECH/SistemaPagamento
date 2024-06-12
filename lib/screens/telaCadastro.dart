// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRegisterScreen extends StatefulWidget {
  final String? productId;

  ProductRegisterScreen({super.key, this.productId});

  @override
  _ProductRegisterScreenState createState() => _ProductRegisterScreenState();
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int _recurrencePeriod = 30;
  String _paymentOption = 'Cartão de crédito/débito';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      _loadProduct();
    }
  }

  void _loadProduct() async {
    setState(() {
      _isLoading = true;
    });
    DocumentSnapshot product = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get();
    _nameController.text = product['name'];
    _priceController.text = product['price'].toString();
    _recurrencePeriod = product['recurrencePeriod'];
    _paymentOption = product['paymentOption'];
    setState(() {
      _isLoading = false;
    });
  }

  void _registerOrEditProduct() async {
    if (_formKey.currentState!.validate()) {
      if (widget.productId == null) {
        // Register new product
        await FirebaseFirestore.instance.collection('products').add({
          'name': _nameController.text,
          'price': double.parse(_priceController.text),
          'recurrencePeriod': _recurrencePeriod,
          'paymentOption': _paymentOption,
        });
      } else {
        // Update existing product
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .update({
          'name': _nameController.text,
          'price': double.parse(_priceController.text),
          'recurrencePeriod': _recurrencePeriod,
          'paymentOption': _paymentOption,
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Produto ${widget.productId == null ? 'registrado' : 'atualizado'} com sucesso!')));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productId == null
            ? 'Registro de produtos'
            : 'Edição de produtos'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nome do produto'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor digite o nome do produto';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'Preço'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor digite o preço';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<int>(
                      value: _recurrencePeriod,
                      decoration:
                          InputDecoration(labelText: 'Periodo de recorrência'),
                      items: [30, 60, 90].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value dias'),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _recurrencePeriod = newValue!;
                        });
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _paymentOption,
                      decoration:
                          InputDecoration(labelText: 'Opção de Pagamento'),
                      items: ['Cartão de crédito/débito', 'Pix', 'Ambos']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _paymentOption = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _registerOrEditProduct,
                      child: Text(widget.productId == null
                          ? 'Registrar produto'
                          : 'Editar produto'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
