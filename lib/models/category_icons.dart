const List<String> kCategories = [
  'Общее',
  'Еда',
  'Одежда',
  'Техника',
  'Аксессуары',
];

const Map<String, String> kCategoryIconUrl = {
  'Общее':    'https://cdn-icons-png.flaticon.com/512/1685/1685513.png',
  'Еда':    'https://cdn-icons-png.flaticon.com/512/415/415733.png',
  'Одежда':     'https://cdn-icons-png.flaticon.com/512/2954/2954918.png',
  'Техника':    'https://cdn-icons-png.flaticon.com/512/3362/3362661.png',
  'Аксессуары': 'https://cdn-icons-png.flaticon.com/512/3674/3674333.png',
};

String categoryIcon(String category) {
  return kCategoryIconUrl[category] ?? kCategoryIconUrl['Общее']!;
}
