import 'package:flutter/material.dart';
import 'package:untitled6/AddProduct.dart';

import 'Product.dart';

const String _baseURL = 'testingprojects.atwebpages.com';

class Page3 extends StatefulWidget {
  final int skinId;
  const Page3({Key? key, required this.skinId}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {

  bool _load = false;
  String t = '';


  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }

  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateProduct(widget.skinId,update);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    if (MediaQuery
        .of(context)
        .orientation == Orientation.landscape) {
      screenWidth = screenWidth * 0.8;
    }


    return Scaffold(
    appBar: AppBar(actions: [
    IconButton(onPressed: !_load ? null : () {
      setState(() {
        _load = false; // show progress bar
        updateProduct(widget.skinId,update); // update data asynchronously
      });
    }, icon: const Icon(Icons.refresh)),
      IconButton(onPressed: () {
        setState(() { // open the search product page
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddProduct())
          );
        });
      }, icon: const Icon(Icons.add))
    ],
        title: const Text('Available Products',style:TextStyle(
            color: Colors.white70,
            fontSize: 30
        )),

      centerTitle: true,
      backgroundColor: Colors.pink,

    ),
    // load products or progress bar
    body: _load ? const ShowProducts() : const Center(
    child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
    )




    );
  }
}






