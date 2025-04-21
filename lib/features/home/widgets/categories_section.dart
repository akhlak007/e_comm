import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../core/models/category.dart';
import '../../../core/providers/app_provider.dart';
import '../../../core/theme/app_theme.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Column(
      children: [
        // Header with title and see all
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: AppTheme.heading3,
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all categories
                },
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        
        // Categories list
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: dummyCategories.length,
            itemBuilder: (context, index) {
              final category = dummyCategories[index];
              final isSelected = appProvider.selectedCategoryIndex == index;
              
              return CategoryItem(
                category: category,
                isSelected: isSelected,
                onTap: () {
                  appProvider.selectCategory(index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.grey[100],
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      )
                    : null,
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: category.icon,
                  height: 28,
                  width: 28,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black,
                  placeholder: (context, url) => CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Category Name
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}