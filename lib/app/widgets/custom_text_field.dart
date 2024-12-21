import "package:flutter/material.dart";

class CustomTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String prefixText;

  const CustomTextField(this.textFieldController,
      {required this.prefixText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      height: 60,
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
              offset: Offset(2, 2),
              color: Colors.grey.shade300,
              blurRadius: 15)
        ],
        color: Color(0xFFF9F9F9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(

        children: [
          Center(
            child: Text(
              "$prefixText   ",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              cursorColor: Colors.green,
              cursorHeight: 22,
              controller: textFieldController,
              decoration: InputDecoration(
                border: InputBorder.none,

              ),
            ),
          ),
        ],
      ),
    );
  }
}