import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/providers/app_provider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/special_offers.dart';
import '../widgets/categories_section.dart';
import '../widgets/flash_sale_section.dart';
import '../widgets/bottom_navigation.dart';
import 'chatscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Use ListView instead of Column + SingleChildScrollView
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: const [
              // Search bar always visible at top
              SearchBarWidget(),

              // Spacing
              SizedBox(height: 16),

              // Special offers carousel
              SpecialOffers(),

              // Spacing
              SizedBox(height: 24),

              // Categories
              CategoriesSection(),

              // Spacing
              SizedBox(height: 24),

              // Flash sale
              FlashSaleSection(),

              // Bottom padding so last element isn't flush to bottom bar
              SizedBox(height: 16),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
