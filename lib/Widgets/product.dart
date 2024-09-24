import 'package:crud/Screens/update_product_screen.dart';
import 'package:crud/models/product_in.dart';
import 'package:flutter/material.dart';
//import 'package:crud/Screens/product_list_screen.dart';

class Product extends StatelessWidget {
  const Product({
    super.key,
    required this.pdt, required this.deleteProduct,
  });

  final ProductIn pdt;
  final Future<void> Function(String) deleteProduct;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(pdt.productName),
      tileColor: Colors.white60,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code: ${pdt.productCode}'),
          Text('Price: ${pdt.unitPrice}'),
          Text('Quantity: ${pdt.quantity}'),
          Text('Total: ${pdt.totalPrice}'),
          const Divider(),
          OverflowBar(
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UpdateProductScreen(pdt.id);
                    }));
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                  label: const Text('Edit')),
              TextButton.icon(
                  onPressed: () {
                    showDialog(context: context, builder: (_)=>AlertDialog(
                        title: const Text('Are you sure?'),
                      content: const Text('Tap Yes if you are and No if you are not'),
                      actions: [
                        MaterialButton(onPressed: (){
                          deleteProduct(pdt.id);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product deleted')));
                        },
                        child: const Text('Yes'),),
                        MaterialButton(onPressed: (){
                          Navigator.pop(context);
                        },
                          child: const Text('No'),)
                      ],
                    ));
                    //deleteProduct(pdt.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.redAccent),
                  )),
            ],
          )
        ],
      ),
    );
  }

}
