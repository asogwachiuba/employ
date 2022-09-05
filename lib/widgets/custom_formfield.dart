import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';
import '../constants/custom_fonts.dart';

class CustomFormField extends StatefulWidget {
  TextEditingController controller;
  Function(String)? onSubmit;
  String nameOfTextField;
  String hintText;
  IconData icon;
  bool hidePassword;
  String? Function(String?)? validator;

  CustomFormField({
    required this.nameOfTextField,required this.hintText,required this.controller,
    required this.icon, this.onSubmit, this.hidePassword = false,this.validator,
     Key? key}) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}
class _CustomFormFieldState extends State<CustomFormField> {
  bool _hidePassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CFont.small(widget.nameOfTextField, color: CColor.black, align: TextAlign.start),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: CColor.grey, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              obscureText: _hidePassword,
              controller: widget.controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: widget.hintText,
                  suffixIcon: widget.hidePassword == true ? GestureDetector(
                      child: _hidePassword == true ? const Icon(Icons.visibility_off_outlined):
                      const Icon(Icons.visibility_outlined),
                  onTap: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                  },) : Icon(widget.icon),
                  border: InputBorder.none
              ),
            ),
          )
        ],
      ),
    );
  }
}
