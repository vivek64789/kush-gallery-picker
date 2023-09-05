import 'package:flutter/material.dart';
import 'package:kush_gallery_picker/src/camera/src/widgets/ui_handler.dart';

import 'package:kush_gallery_picker/assets/icons/custom_icons.dart';
import 'package:kush_gallery_picker/kush_gallery_picker.dart';
import 'package:kush_gallery_picker/src/camera/src/widgets/camera_builder.dart';

///
class CameraCloseButton extends StatelessWidget {
  ///
  const CameraCloseButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  ///
  final CamController controller;

  @override
  Widget build(BuildContext context) {
    return CameraBuilder(
      controller: controller,
      builder: (value, child) {
        if (value.hideCameraCloseButton) {
          return const SizedBox();
        }
        return child!;
      },
      child: InkWell(
        onTap: Navigator.of(context).pop,
        child: Container(
          height: 36,
          width: 36,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black26,
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
