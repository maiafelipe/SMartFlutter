import 'package:flutter/material.dart';

class FormFieldPadded extends StatelessWidget {
  final TextEditingController controllerField;
  final String label;
  final String hint;
  final IconData? icon;

  const FormFieldPadded(
    this.controllerField,
    this.label,
    this.hint, {
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controllerField,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}
