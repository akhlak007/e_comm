// lib/features/home/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/models/product.dart';
import '../../../core/theme/app_theme.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 150 / 200,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppTheme.shadowSmall,
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              // Image section fixed flex
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Hero(
                      tag: 'product-${product.id}',
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (_, __) => Container(color: Colors.grey[200]),
                        errorWidget: (_, __, ___) => Container(color: Colors.grey[200], child: const Icon(Icons.error)),
                      ),
                    ),
                    if (product.discountedPrice < product.price)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '-${((1 - product.discountedPrice / product.price) * 100).toInt()}%',
                            style: AppTheme.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added ${product.name} to wishlist')),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: AppTheme.shadowSmall),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.favorite_border, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Info section
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category,
                        style: AppTheme.caption.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        style: AppTheme.bodySmall.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '\\${product.discountedPrice.toStringAsFixed(2)}',
                            style: AppTheme.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          if (product.discountedPrice < product.price) ...[
                            const SizedBox(width: 6),
                            Text(
                              '\\${product.price.toStringAsFixed(2)}',
                              style: AppTheme.caption.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

