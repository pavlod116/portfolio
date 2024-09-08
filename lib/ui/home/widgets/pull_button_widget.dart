import 'package:flutter/material.dart';

class PullButtonWidget extends StatelessWidget {
  final Function(DragUpdateDetails) onHorizontalDragUpdate;
  final Function(DragEndDetails) onHorizontalDragEnd;
  final double dragPosition;

  const PullButtonWidget({
    super.key,
    required this.onHorizontalDragUpdate,
    required this.onHorizontalDragEnd,
    required this.dragPosition,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: SizedBox(
        height: 50,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: dragPosition,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                ),
              ),
            ),
            Center(
              child: Text(
                'Pull Create Card',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
