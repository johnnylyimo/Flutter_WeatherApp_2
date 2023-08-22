import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  const HourlyForecastItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      color: const Color(0xff99F6EC),
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: const Column(
          children: [
            Text(
              '03:00',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Icon(
              Icons.cloud,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '120.23',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
