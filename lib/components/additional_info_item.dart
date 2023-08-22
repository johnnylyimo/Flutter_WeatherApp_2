import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  const AdditionalInfoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Icons.water_drop,
          size: 32,
        ),
        SizedBox(
          height: 5,
        ),
        Text('Humidity'),
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
