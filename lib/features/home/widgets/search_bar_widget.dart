import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingM),
      child: Row(
        children: [
          // Search Input
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  hintStyle: AppTheme.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.paddingM,
                    vertical: AppTheme.paddingS,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.paddingS),

          // Filter Button
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(AppTheme.radiusL),
            ),
            child: IconButton(
              icon: const Icon(Icons.tune_rounded, size: 20),
              onPressed: () => _showFilterOptions(context),
              color: Theme.of(context).colorScheme.onPrimary,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusL),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppTheme.paddingL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Filter Products',
                    style: AppTheme.heading2.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: AppTheme.paddingM),

              Text(
                'Price Range',
                style: AppTheme.heading3.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppTheme.paddingS),
              RangeSlider(
                values: const RangeValues(10, 100),
                min: 0,
                max: 1000,
                divisions: 100,
                labels: const RangeLabels('\$10', '\$100'),
                onChanged: (RangeValues values) {},
                activeColor: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: AppTheme.paddingL),
              Text(
                'Categories',
                style: AppTheme.heading3.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppTheme.paddingS),
              Wrap(
                spacing: AppTheme.paddingS,
                children: [
                  'All',
                  'Clothes',
                  'Electronics',
                  'Shoes',
                  'Watches',
                  'Accessories',
                ].map((category) => FilterChip(
                  label: Text(
                    category,
                    style: AppTheme.bodySmall.copyWith(
                      color: category == 'All'
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  selected: category == 'All',
                  onSelected: (selected) {},
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                )).toList(),
              ),

              const SizedBox(height: AppTheme.paddingL),
              Text(
                'Rating',
                style: AppTheme.heading3.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppTheme.paddingS),
              Row(
                children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star_rounded,
                    color: index < 4
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    size: 32,
                  ),
                ),
              ),

              const SizedBox(height: AppTheme.paddingL),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.paddingM,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusL),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}