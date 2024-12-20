import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Icon icon;
  final String category;

  const CategoryItem({required this.icon,required this.category,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        SizedBox(height: 5),
        Text(category),
      ],
    );
  }
}
