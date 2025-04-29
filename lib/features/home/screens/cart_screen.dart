import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class CartItem {
  final String name;
  final int quantity;
  final double price;
  final double? originalPrice;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.originalPrice,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart',
      theme: ThemeData(useMaterial3: true),
      home: const CartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  List<CartItem> get _items => [
    CartItem(name: 'Cap', quantity: 1, price: 42.95),
    CartItem(name: 'White T-Shirt', quantity: 2, price: 47.98, originalPrice: 2 * 23.99),
    CartItem(name: 'Sneaker', quantity: 1, price: 33.50),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _items;
    final productsTotal = items.fold<double>(0, (sum, i) => sum + (i.originalPrice ?? i.price));
    final discount = items.fold<double>(
        0, (sum, i) => sum + ((i.originalPrice != null ? i.originalPrice! - i.price : 0)));
    final grandTotal = items.fold<double>(0, (sum, i) => sum + i.price);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, idx) {
                final item = items[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text('Qty: ${item.quantity}',
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (item.originalPrice != null)
                            Text(
                              '\$${item.originalPrice!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Text('\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildTotalRow('Subtotal', productsTotal),
                _buildTotalRow('Discount', -discount, isDiscount: true),
                const Divider(),
                _buildTotalRow('Total', grandTotal, isBold: true),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: Text('Pay \$${grandTotal.toStringAsFixed(2)}'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Continue Shopping'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount,
      {bool isDiscount = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
          Text(
            (amount < 0 ? '- ' : '') + '\$${amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: isDiscount ? Colors.red : Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
