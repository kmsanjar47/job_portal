import 'package:flutter/material.dart';

class FeaturedJob extends StatelessWidget {
  final String assetPath;
  final String jobTitle;
  const FeaturedJob({required this.assetPath,required this.jobTitle,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.network(assetPath,fit: BoxFit.cover,),
        ),
        SizedBox(height: 10),
        Text(
          jobTitle,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );;
  }
}
