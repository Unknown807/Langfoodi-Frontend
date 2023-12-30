import 'package:flutter/material.dart';

class PlusFloatingButton extends StatelessWidget {
  const PlusFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {

        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0), // Adjust the radius
        ),
        backgroundColor: const Color(0xFF189A03),
        child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40
        )
    );
  }
}
