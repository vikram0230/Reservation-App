import'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.labelText, this.icon, this.inputType, this.caps, this.initialText});
  final String labelText;
  final Icon icon;
  final TextInputType inputType;
  final TextCapitalization caps;
  final String initialText;
  String valuePassed;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: initialText);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value){
          valuePassed = value;
        },
        controller: controller,
        keyboardType: inputType,
        textCapitalization: caps,
        cursorColor: Color.fromRGBO(0, 183, 212, 1),
        style: TextStyle(color: Color.fromRGBO(0, 183, 212, 1)),
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: labelText,
          labelStyle: TextStyle(color: Color.fromRGBO(0, 183, 212, 0.3)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 183, 212, 1),
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(0, 183, 212, 1),
                  width: 2
              )
          ),
        ),
      ),
    );
  }
}