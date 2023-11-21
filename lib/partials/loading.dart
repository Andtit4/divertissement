import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TiLoading extends StatefulWidget {
  const TiLoading({super.key});

  @override
  State<TiLoading> createState() => _TiLoadingState();
}

class _TiLoadingState extends State<TiLoading> {
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.beat(color: Colors.white, size: 40);
  }
}
