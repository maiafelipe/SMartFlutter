import 'package:flutter/material.dart';

class CenterLeftText extends StatelessWidget {
  final String label;
  const CenterLeftText(this.label,{super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(label),
    );
  }
}