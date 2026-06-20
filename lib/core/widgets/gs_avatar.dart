import 'package:flutter/material.dart';

class GSAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Color borderColor;
  final double borderWidth;

  const GSAvatar({
    required this.imageUrl,
    required this.size,
    required this.borderColor,
    required this.borderWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
      ),
    );
  }
}
