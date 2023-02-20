// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';

import '../../../../kush_gallery_picker.dart';

///
class CameraBuilder extends StatelessWidget {
  ///
  const CameraBuilder({
    Key? key,
    required this.controller,
    required this.builder,
    this.child,
  }) : super(key: key);

  ///
  final CamController controller;

  ///
  final Widget Function(CamValue value, Widget? child) builder;

  ///
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CamValue>(
      valueListenable: controller,
      builder: (context, v, c) => builder(v, c),
      child: child,
    );
  }
}
