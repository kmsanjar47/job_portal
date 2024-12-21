import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  Function()? onTap;
  final Color color;
  IconData? suffixIcon;
  final String text;
  CustomSubmitButton({required this.text,this.suffixIcon,this.onTap,required this.color,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),

        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            suffixIcon != null?Icon(suffixIcon,color: Colors.white,):Container(),
            suffixIcon != null?SizedBox(width: 5,):Container(),
            Text(text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),),),
    );
  }
}