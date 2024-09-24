import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  final String id;

  const UpdateProductScreen(this.id, {super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _total = TextEditingController();
  final TextEditingController _img = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Product data'),
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
                    labelText: 'Name',
                  ),
                  validator: (String? value) {
                    //not working
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _code,
                  decoration: const InputDecoration(
                    labelText: 'Code',
                  ),
                  validator: (String? value) {
                    //not working
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _price,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (String? value) {
                    //not working
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _quantity,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                  validator: (String? value) {
                    //not working
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _total,
                  decoration: const InputDecoration(
                    labelText: 'Total',
                  ),
                  validator: (String? value) {
                    //not working
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _img,
                  decoration: const InputDecoration(
                    labelText: 'Image',
                  ),
                  validator: (String? value) {
                    //not working
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid input';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    onTapUpdateButton();
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ));
  }

  void onTapUpdateButton() {
    if (_formkey.currentState!.validate()) {
      updateproduct();
    }
  }

  Future<void> updateproduct() async {
    setState(() {});
    Uri uri =
        Uri.parse('http://152.42.163.176:2008/api/v1/UpdateProduct/$_id');
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

    if (res.statusCode == 200) {
      _clearTextfields();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Product info updated')));
    }else {
      print('http://152.42.163.176:2008/api/v1/ReadProductById/$_id');
    }
    setState(() {});
  }

  void _clearTextfields() {
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
