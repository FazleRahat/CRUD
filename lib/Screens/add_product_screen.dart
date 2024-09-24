import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _total = TextEditingController();
  final TextEditingController _img = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    //hintText: 'Student\'s Name',
                    labelText: 'Name',
                  ),
                  validator: (String? value) {                  //not working
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                  controller: _code,
                  decoration: const InputDecoration(
                    //hintText: 'Student\'s Roll',
                    labelText: 'Code',
                  ),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                  controller: _price,
                  decoration: const InputDecoration(
                    //hintText: 'Student\'s Roll',
                    labelText: 'Price',
                  ),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                  controller: _quantity,
                  decoration: const InputDecoration(
                    //hintText: 'Student\'s Roll',
                    labelText: 'Quantity',
                  ),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                  controller: _total,
                  decoration: const InputDecoration(
                    //hintText: 'Student\'s Roll',
                    labelText: 'Total',
                  ),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                  controller: _img,
                  decoration: const InputDecoration(
                    //hintText: 'Student\'s Roll',
                    labelText: 'Image',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    opTapAddProductButton();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ));
  }

  void opTapAddProductButton() {
    if (_formkey.currentState!.validate()) {
      addnewproduct();
    }
  }

  Future<void> addnewproduct() async {
    setState(() {});
    Uri uri = Uri.parse('http://152.42.163.176:2008/api/v1/CreateProduct');
    Map<String, dynamic> resbody = {
      "ProductName": _name.text,
      "ProductCode": _code.hashCode,
      "Img": _img.text,
      "Qty": _quantity.hashCode,
      "UnitPrice": _price.hashCode,
      "TotalPrice": _total.hashCode
    };
    Response res = await post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(resbody));

    print(res.statusCode);
    print(res.body);

    if (res.statusCode==200){
      _clearTextfields();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New product added')));
    }
    setState(() {});
  }

  void _clearTextfields(){
    _name.clear();
    _code.clear();
    _price.clear();
    _quantity.clear();
    _total.clear();
    _img.clear();
  }

  @override
  void dispose() {
    _name.dispose;
    _code.dispose();
    _price.dispose();
    _quantity.dispose();
    _total.dispose();
    _img.dispose();
    super.dispose();
  }
}
