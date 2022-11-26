import 'package:flutter/material.dart';

class TextFieldAddressWidget extends StatelessWidget {
  String? hint;
  TextEditingController? controller;

  TextFieldAddressWidget({
    this.hint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(),
          decoration: InputDecoration.collapsed(
            hintText: hint,
          ),
          validator: (value) =>
              value!.isEmpty ? "Field can not be Empty." : null,
        ),
      ),
    );
  }
}
