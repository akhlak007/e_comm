class Category {
  final String id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

List<Category> dummyCategories = [
  Category(
    id: '1',
    name: 'Clothes',
    icon: 'https://cdn-icons-png.flaticon.com/512/2589/2589625.png',
  ),
  Category(
    id: '2',
    name: 'Electronics',
    icon: 'https://cdn-icons-png.flaticon.com/512/3659/3659898.png',
  ),
  Category(
    id: '3',
    name: 'Shoes',
    icon: 'https://cdn-icons-png.flaticon.com/512/2589/2589145.png',
  ),
  Category(
    id: '4',
    name: 'Watch',
    icon: 'https://cdn-icons-png.flaticon.com/512/3574/3574860.png',
  ),
];