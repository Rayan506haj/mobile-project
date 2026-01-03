import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const String _baseURL = 'testingprojects.atwebpages.com';


class Product {
  final int Pid;
  final String name;
  final String description;
  final double price;
  final String image;
  final String skinType;
  bool _selected = false;


  Product(this.Pid,this.name,this.description, this.price, this.image, this.skinType);

  // getter
  bool get selected => _selected;
  set selected(bool e) => _selected = e;

  // product description
  @override
  String toString() {
    return '$name - \$$price';
  }
}


List<Product> _products = [];


void updateProduct(int Sid,Function(bool success) update) async {
  try {
    final url = Uri.http(_baseURL, 'getProduct.php',{'Sid': Sid.toString()});
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds


    if (response.statusCode == 200) {
      _products.clear();
      // if successful call
      final jsonResponse = convert.jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) { // iterate over all rows in the json array
        Product p = Product(
          int.parse(row['Pid'].toString()),
          row['name'].toString(),
          row['description'].toString() ,
          double.parse(row['price'].toString()),
          row['image'].toString(),
          row['skinType'].toString(),

        );
        _products.add(p);
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
    else{
      update(false);
    }
  }
  catch(e) {
    print(e.toString());
    update(false); // inform through callback that we failed to get data
  }
}


class ShowProducts extends StatefulWidget {

  const ShowProducts({ super.key});



  @override

  State<ShowProducts> createState() =>_ShowProductsState();

}



class _ShowProductsState extends State<ShowProducts> {


  double sum = 0;
  String t = 'Total of products: 0 \$';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // REMOVED: Nested Scaffold and AppBar.
    // We use a Column so the "Total" stays visible at the top or bottom.
    return Column(
      children: [
        // Display the total price in a Container instead of a second AppBar
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/${product.image}',
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('${product.name}: ${product.price} \$'),
                      ),
                      Checkbox(
                        value: product.selected,
                        onChanged: (bool? newValue) { // Use bool?
                          setState(() {
                            product.selected = newValue ?? false;
                            if (product.selected) {
                              sum += product.price;
                            } else {
                              sum -= product.price;
                            }
                            Text(t = 'Total sum of products: ${sum.toStringAsFixed(2)} \$');
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}



