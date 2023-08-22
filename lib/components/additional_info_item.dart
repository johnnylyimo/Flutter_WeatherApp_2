import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        SizedBox(
          height: 5,
        ),
        Text(label),
        SizedBox(
          height: 5,
        ),
        Text(
          '91',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
