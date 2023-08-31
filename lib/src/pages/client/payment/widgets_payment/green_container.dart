import 'package:flutter/material.dart';

class GreenContainer extends StatelessWidget {
  final String container;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;

  const GreenContainer({
    required this.container,
    this.width,
    this.height,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 108, 53, 0.61),
          borderRadius: BorderRadius.circular(15),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              container,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
