import 'dart:convert';
import 'package:crud/Screens/add_product_screen.dart';
import 'package:crud/models/product_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Widgets/product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getProductList();
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Text('List of Products'),
        centerTitle: true,
      ),
      body: _inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Product(
                      deleteProduct: _deleteProduct,
                      pdt: productList[index], //confusion
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: productList.length),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddProductScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<ProductIn> productList = [];

  Future<void> getProductList() async {
    _inProgress = true;
    setState(() {});

    Uri uri = Uri.parse('http://152.42.163.176:2008/api/v1/ReadProduct');

    Response response = await get(uri);

    print(response);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      productList.clear();
      Map<String, dynamic> resmap = jsonDecode(response.body);
      for (var item in resmap['data']) {
        ProductIn productIn = ProductIn(
          id: item['_id'] ?? '',
          productName: item['ProductName'] ?? '',
          productCode: item['ProductCode'] ?? 0,
          productImage: item['Img'] ?? '',
          unitPrice: item['UnitPrice'] ?? 0,
          quantity: item['Qty'] ?? 0,
          totalPrice: item['TotalPrice'] ?? 0,
        );
        productList.add(productIn);
      }
    }
    _inProgress = false;
    setState(() {});
  }

  Future<void> _deleteProduct(String id) async {
    Uri uri = Uri.parse('http://152.42.163.176:2008/api/v1/DeleteProduct/$id');
    Response res = await get(uri);
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      setState(() {});
    } else {
      print('failed to delete');
    }
  }
}
