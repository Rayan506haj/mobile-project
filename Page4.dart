import 'package:flutter/material.dart';
import 'Product.dart';
import 'User.dart';


class Page4 extends StatefulWidget {
  final List<Product> products;
  final User user;
  final double totalPrice;

  const Page4({Key? key, required this.products, required this.user, required this.totalPrice}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Amount: \$${widget.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Selected Items:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),

              ...widget.products.map((p) => Text(
                '- ${p.name} (\$${p.price.toStringAsFixed(2)})',
                style: const TextStyle(fontSize: 18),
              )).toList(),

              const SizedBox(height: 50),


              Text(

                'Thank you ${widget.user.name} for choosing us to be part of your daily routine. We appreciate your trust and hope you enjoy your new products!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}