import 'package:flutter/material.dart';

class RecentJob extends StatelessWidget {
  final String postTitle;
  final String companyName;
  final String assetPath;
  const RecentJob({required this.assetPath,required this.companyName,required this.postTitle,super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      leading: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10)
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(postTitle),
      subtitle: Text(companyName),
    );;
  }
}
