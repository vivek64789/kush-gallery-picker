import 'package:flutter/material.dart';

import 'package:kush_gallery_picker/kush_gallery_picker.dart';
import 'package:kush_gallery_picker/src/animations/animations.dart';
import 'package:kush_gallery_picker/src/editor/src/widgets/editor_builder.dart';

///
class EditorTextfieldButton extends StatelessWidget {
  ///
  const EditorTextfieldButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  ///
  final KushEditingController controller;

  @override
  Widget build(BuildContext context) {
    return EditorBuilder(
      controller: controller,
      builder: (context, value, child) {
        final crossFadeState =
            value.hasStickers || value.hasFocus || value.isEditing
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond;
        return AppAnimatedCrossFade(
          firstChild: const SizedBox(),
          secondChild: child!,
          crossFadeState: crossFadeState,
        );
      },
      child: GestureDetector(
        onTap: () {
          controller.updateValue(hasFocus: true);
        },
        child: const Text(
          'Tap to type...',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
