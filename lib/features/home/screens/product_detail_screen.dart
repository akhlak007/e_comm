// lib/features/product/presentation/product_detail_screen.dart
import 'package:ecommerce_app/features/home/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/models/product.dart';
import '../../../core/theme/app_theme.dart';


class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  void _placeOrder(BuildContext context) {
    // Navigate to the payment screen, passing the product details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          product: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: textTheme.titleLarge,
        ),
        backgroundColor: colorScheme.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: 'product-${product.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: product.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  height: 300,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  height: 300,
                  color: Colors.grey[200],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            product.name,
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                product.discountedPrice < product.price
                    ? '\\${product.discountedPrice.toStringAsFixed(2)}'
                    : '\\${product.price.toStringAsFixed(2)}',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              if (product.discountedPrice < product.price) ...[
                const SizedBox(width: 8),
                Text(
                  '\\${product.price.toStringAsFixed(2)}',
                  style: textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'No description available for this product.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _placeOrder(context),
              child: const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}