import 'package:flutter/material.dart';

import '../../domain/entities/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    this.onTap,
  });

  final Category category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.category),
      title: Text(category.name),
      subtitle: Text('ID: ${category.id}'),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
