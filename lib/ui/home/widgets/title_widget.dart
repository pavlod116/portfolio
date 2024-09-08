import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top / 0.6, left: 20),
      child: const Text(
        'Card Portfolio',
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32),
      ),
    );
  }
}
