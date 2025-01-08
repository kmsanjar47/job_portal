import 'package:flutter/material.dart';

class JobHistoryTile extends StatelessWidget {
  final String postTitle;
  final String companyName;
  final String assetPath;
  final int totalApplications;
  const JobHistoryTile({required this.assetPath,required this.companyName,required this.postTitle,required this.totalApplications,super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text(totalApplications.toString()),
      style: ListTileStyle.list,
      leading: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10)
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(postTitle),
      subtitle: Text(companyName),
    );;
  }
}
