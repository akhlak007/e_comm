// lib/features/payment/presentation/payment_screen.dart
import 'package:flutter/material.dart';
import '../../../core/models/product.dart';

class PaymentScreen extends StatefulWidget {
  final Product product;
  const PaymentScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedIndex = 0;
  final List<_PaymentMethod> _methods = [
    _PaymentMethod(icon: Icons.credit_card, label: 'Credit Card'),
    _PaymentMethod(icon: Icons.account_balance_wallet, label: 'PayPal'),
    _PaymentMethod(icon: Icons.phone_iphone, label: 'Apple Pay'),
  ];

  void _onPayNow() {
    final product = widget.product;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successful for ${product.name}!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final amount = (widget.product.discountedPrice < widget.product.price
        ? widget.product.discountedPrice
        : widget.product.price)
        .toStringAsFixed(2);

    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Payment', style: textTheme.titleMedium?.copyWith(color: Colors.black87)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Select Payment Method', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _methods.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final method = _methods[index];
                  final selected = index == _selectedIndex;
                  return _PaymentOptionCard(
                    icon: method.icon,
                    label: method.label,
                    selected: selected,
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                'Order Total: \$$amount',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onPayNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                  ),
                  child: Text(
                    'Confirm & Pay',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOptionCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: selected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: selected ? colorScheme.primary : Colors.black54),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? Colors.black87 : Colors.black54,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? colorScheme.primary : Colors.grey.shade300,
                  width: 2,
                ),
                color: selected ? colorScheme.primary : Colors.transparent,
              ),
              child: selected
                  ? Icon(Icons.check, size: 16, color: colorScheme.onPrimary)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethod {
  final IconData icon;
  final String label;
  const _PaymentMethod({required this.icon, required this.label});
}

