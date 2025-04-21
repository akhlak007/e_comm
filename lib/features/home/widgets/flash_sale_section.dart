import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/product.dart';
import '../../../core/providers/app_provider.dart';
import '../../../core/theme/app_theme.dart';
import 'product_card.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    const filterTypes = ['All', 'Newest', 'Popular', 'Clothes'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                'Flash Sale',
                style: AppTheme.heading3,
              ),
              const SizedBox(width: 10),
              const Text(
                'Closing in:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 5),
              _buildTimeUnit(context, appProvider.hours.toString().padLeft(2, '0')),
              const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildTimeUnit(context, appProvider.minutes.toString().padLeft(2, '0')),
              const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildTimeUnit(context, appProvider.seconds.toString().padLeft(2, '0')),
            ],
          ),
        ),

        SizedBox(
          height: 40,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: filterTypes.length,
            itemBuilder: (context, index) {
              final isSelected = appProvider.selectedFlashSaleFilter == index;

              return GestureDetector(
                onTap: () {
                  appProvider.selectFlashSaleFilter(index);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      filterTypes[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: dummyProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(product: dummyProducts[index]);
          },
        ),
      ],
    );
  }

  Widget _buildTimeUnit(BuildContext context, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}