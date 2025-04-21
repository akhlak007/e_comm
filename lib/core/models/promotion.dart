class Promotion {
  final String id;
  final String title;
  final String subtitle;
  final String discount;
  final String image;
  final String tag;
  final String disclaimer;
  final String buttonText;

  Promotion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.image,
    required this.tag,
    required this.disclaimer,
    required this.buttonText,
  });
}

List<Promotion> dummyPromotions = [
  Promotion(
    id: '1',
    title: 'Get Special Offer',
    subtitle: 'Up to',
    discount: '40',
    image: 'https://images.unsplash.com/photo-1581338834647-b0fb40704e21',
    tag: 'Limited time!',
    disclaimer: 'All Services Available | T&C Applied',
    buttonText: 'Claim',
  ),
  Promotion(
    id: '2',
    title: 'New Season Sale',
    subtitle: 'Up to',
    discount: '50',
    image: 'https://images.unsplash.com/photo-1483985988355-763728e1935b',
    tag: 'New Arrivals!',
    disclaimer: 'All Categories | T&C Applied',
    buttonText: 'Shop Now',
  ),
  Promotion(
    id: '3',
    title: 'Electronics Week',
    subtitle: 'Up to',
    discount: '30',
    image: 'https://images.unsplash.com/photo-1498049794561-7780e7231661',
    tag: 'Tech Deals!',
    disclaimer: 'Selected Items Only | T&C Applied',
    buttonText: 'Get Deal',
  ),
];