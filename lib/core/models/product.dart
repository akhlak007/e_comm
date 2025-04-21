class Product {
  final String id;
  final String name;
  final double price;
  final double discountedPrice;
  final String image;
  final String category;
  final bool isOnSale;
  final bool isNew;
  final bool isPopular;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountedPrice,
    required this.image,
    required this.category,
    this.isOnSale = false,
    this.isNew = false,
    this.isPopular = false,
    this.rating = 0.0,
  });
}

List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Women\'s Red Dress',
    price: 89.99,
    discountedPrice: 49.99,
    image: 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1',
    category: 'Clothes',
    isOnSale: true,
    isNew: true,
    rating: 4.5,
  ),
  Product(
    id: '2',
    name: 'Smart Watch',
    price: 199.99,
    discountedPrice: 149.99,
    image: 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a',
    category: 'Watch',
    isOnSale: true,
    isPopular: true,
    rating: 4.8,
  ),
  Product(
    id: '3',
    name: 'Running Shoes',
    price: 129.99,
    discountedPrice: 99.99,
    image: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    category: 'Shoes',
    isOnSale: true,
    isPopular: true,
    rating: 4.2,
  ),
  Product(
    id: '4',
    name: 'Wireless Earbuds',
    price: 79.99,
    discountedPrice: 59.99,
    image: 'https://images.unsplash.com/photo-1606220588913-b3aacb4d2f46',
    category: 'Electronics',
    isOnSale: true,
    isNew: true,
    rating: 4.6,
  ),
];