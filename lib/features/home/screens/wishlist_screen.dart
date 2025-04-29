import 'package:flutter/material.dart';

/// Simple model for a wishlist item.
class WishlistItem {
  final String name;
  final String imageUrl;
  final double price;
  final double? discountedPrice;

  WishlistItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.discountedPrice,
  });
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Sample wishlist data with real Unsplash images
  final List<WishlistItem> _items = [
    WishlistItem(
      name: 'Leather Backpack Deluxe Edition - 35L Capacity',
      imageUrl: 'https://images.unsplash.com/photo-1598970434795-0c54fe7c0642',
      price: 79.99,
      discountedPrice: 59.99,
    ),
    WishlistItem(
      name: 'Running Sneakers Ultra Comfort Series',
      imageUrl: 'https://images.unsplash.com/photo-1572441710260-0bb7a161345f',
      price: 120.00,
    ),
    WishlistItem(
      name: 'Wireless Noise-Cancelling Headphones Pro',
      imageUrl: 'https://images.unsplash.com/photo-1585386959984-a4155220c822',
      price: 199.99,
      discountedPrice: 149.99,
    ),
  ];

  final Set<int> _selected = {};

  void _removeSelected() {
    final toRemove = _selected.toList()..sort((a, b) => b.compareTo(a));
    for (var idx in toRemove) {
      _items.removeAt(idx);
    }
    _selected.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // App Bar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'My Wishlist',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: _selected.isEmpty ? null : () => setState(_removeSelected),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Item list
              Expanded(
                child: ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, idx) {
                    final item = _items[idx];
                    final isSelected = _selected.contains(idx);

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Checkbox
                          GestureDetector(
                            onTap: () => setState(() {
                              isSelected ? _selected.remove(idx) : _selected.add(idx);
                            }),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? cs.primary : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? cs.primary : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Thumbnail
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              '${item.imageUrl}?w=80&h=80&fit=crop',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              loadingBuilder: (c, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey.shade200,
                                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                );
                              },
                              errorBuilder: (c, _, __) => Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.broken_image, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Name & price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Use Flexible so text wraps nicely
                                Flexible(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    if (item.discountedPrice != null) ...[
                                      Text(
                                        '\$${item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade500,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '\$${item.discountedPrice!.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: cs.primary,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        '\$${item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: cs.onSurface,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Remove button
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            color: Colors.red.shade400,
                            onPressed: () => setState(() {
                              _items.removeAt(idx);
                              _selected.remove(idx);
                            }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _selected.isEmpty ? null : () => setState(_removeSelected),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Remove Selected', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selected.isEmpty ? null : () { /* add to cart */ },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: cs.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Add to Cart', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
