import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class CartItem {
  final String name;
  final int quantity;
  final double price;
  final double? originalPrice;
  final String imageUrl;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
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

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> get _items => [
    CartItem(
      name: 'Cap',
      quantity: 1,
      price: 42.95,
      imageUrl: 'https://images.unsplash.com/photo-1598970434795-0c54fe7c0642',
    ),
    CartItem(
      name: 'White T-Shirt',
      quantity: 2,
      price: 47.98,
      originalPrice: 2 * 23.99,
      imageUrl: 'https://images.unsplash.com/photo-1572441710260-0bb7a161345f',
    ),
    CartItem(
      name: 'Sneaker',
      quantity: 1,
      price: 33.50,
      imageUrl: 'https://images.unsplash.com/photo-1585386959984-a4155220c822',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = _items;
    final productsTotal = items.fold<double>(0, (sum, i) => sum + (i.originalPrice ?? i.price));
    final discount = items.fold<double>(0, (sum, i) => sum + ((i.originalPrice != null ? i.originalPrice! - i.price : 0)));
    final grandTotal = items.fold<double>(0, (sum, i) => sum + i.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              // Clear cart functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, idx) {
                final item = items[idx];
                return Dismissible(
                  key: Key(item.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(idx);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} removed from cart'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              items.insert(idx, item);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                          child: Image.network(
                            item.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 100,
                              height: 100,
                              color: cs.surfaceVariant,
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: cs.outline),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove, size: 16),
                                            onPressed: () {
                                              // Decrease quantity
                                            },
                                          ),
                                          Text(
                                            item.quantity.toString(),
                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add, size: 16),
                                            onPressed: () {
                                              // Increase quantity
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        if (item.originalPrice != null)
                                          Text(
                                            '\$${item.originalPrice!.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: cs.onSurfaceVariant,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                        Text(
                                          '\$${item.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTotalRow('Subtotal', productsTotal),
                _buildTotalRow('Discount', -discount, isDiscount: true),
                const Divider(),
                _buildTotalRow('Total', grandTotal, isBold: true),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Proceed to checkout
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Proceed to Checkout'),
                      const SizedBox(width: 8),
                      Text(
                        '\$${grandTotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Continue shopping
                  },
                  child: const Text('Continue Shopping'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isDiscount = false, bool isBold = false}) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
              color: isBold ? cs.onSurface : cs.onSurfaceVariant,
            ),
          ),
          Text(
            (amount < 0 ? '- ' : '') + '\$${amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: isDiscount ? Colors.red : (isBold ? cs.primary : cs.onSurface),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
