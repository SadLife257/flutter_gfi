import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color imageColor;
  final String imagePath;
  final Function()? onTap;

  SquareTile({
    super.key,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.imageColor = Colors.transparent,
    required this.imagePath,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 4),
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
        ),
        child: imageColor == Colors.transparent ?
        Image.asset(
          imagePath,
          height: 40,
        ) :
        Image.asset(
          imagePath,
          height: 40,
          color: imageColor,
        ),
      ),
    );
  }
}
