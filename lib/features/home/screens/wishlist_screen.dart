import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class _WishlistScreenState extends State<WishlistScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // App Bar
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'My Wishlist',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    if (_selected.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => setState(_removeSelected),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 24),

                // Item list
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ListView.separated(
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, idx) {
                        final item = _items[idx];
                        final isSelected = _selected.contains(idx);

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () => setState(() {
                                isSelected ? _selected.remove(idx) : _selected.add(idx);
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    // Checkbox
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
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
                                    const SizedBox(width: 16),

                                    // Thumbnail
                                    Hero(
                                      tag: 'wishlist_${item.imageUrl}',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          '${item.imageUrl}?w=120&h=120&fit=crop',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (c, child, progress) {
                                            if (progress == null) return child;
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.grey.shade100,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  value: progress.expectedTotalBytes != null
                                                      ? progress.cumulativeBytesLoaded /
                                                          progress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (c, _, __) => Container(
                                            width: 80,
                                            height: 80,
                                            color: Colors.grey.shade100,
                                            child: const Icon(Icons.broken_image,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Name & price
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
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
                                                const SizedBox(width: 8),
                                                Text(
                                                  '\$${item.discountedPrice!.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: cs.primary,
                                                  ),
                                                ),
                                              ] else ...[
                                                Text(
                                                  '\$${item.price.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 18,
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
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _selected.isEmpty ? null : () => setState(_removeSelected),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: BorderSide(color: cs.primary),
                        ),
                        child: Text(
                          'Remove Selected',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: cs.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _selected.isEmpty ? null : () { /* add to cart */ },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: cs.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
