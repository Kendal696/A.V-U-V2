import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Load extends StatefulWidget {
  final int type;
  const Load({required this.type, super.key});
  @override
  State<Load> createState() => _Load();
}

class _Load extends State<Load> {
  Color color = const Color(0xFF9e0044);
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 1:
        return LoadingAnimationWidget.fourRotatingDots(
          color: color,
          size: 30,
        );
      case 2:
        return LoadingAnimationWidget.staggeredDotsWave(
          color: color,
          size: 30,
        );
      case 3:
        return LoadingAnimationWidget.hexagonDots(
          color: color,
          size: 30,
        );
      default:
        return LoadingAnimationWidget.waveDots(
          color: color,
          size: 30,
        );
    }
  }
}
