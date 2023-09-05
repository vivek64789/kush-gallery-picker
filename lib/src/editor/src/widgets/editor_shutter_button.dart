import 'package:flutter/material.dart';

import 'package:kush_gallery_picker/assets/icons/custom_icons.dart';
import 'package:kush_gallery_picker/kush_gallery_picker.dart';
import 'package:kush_gallery_picker/src/animations/animations.dart';
import 'package:kush_gallery_picker/src/camera/src/widgets/ui_handler.dart';
import 'package:kush_gallery_picker/src/editor/src/widgets/editor_builder.dart';

///
class EditorShutterButton extends StatelessWidget {
  ///
  const EditorShutterButton({
    Key? key,
    required this.controller,
    this.onSuccess,
  }) : super(key: key);

  ///
  final KushEditingController controller;

  ///
  final ValueSetter<GalleryPickerEntity>? onSuccess;

  @override
  Widget build(BuildContext context) {
    return EditorBuilder(
      controller: controller,
      builder: (context, value, child) {
        final crossFadeState =
            (controller.currentBackground is GradientBackground &&
                        !value.hasStickers) ||
                    value.isEditing ||
                    value.hasFocus
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond;
        return AppAnimatedCrossFade(
          crossFadeState: crossFadeState,
          firstChild: const SizedBox(),
          secondChild: IgnorePointer(
            ignoring: crossFadeState == CrossFadeState.showFirst,
            child: InkWell(
              onTap: () async {
                if (controller.value.isColorPickerOpen) {
                  controller.updateValue(isColorPickerOpen: false);
                  return;
                }
                final uiHandler = UIHandler.of(context);

                final entity = await controller.completeEditing();
                if (entity != null) {
                  UIHandler.transformFrom = TransitionFrom.topToBottom;
                  if (onSuccess != null) {
                    onSuccess!(entity);
                  } else {
                    uiHandler.pop(entity);
                  }
                } else {
                  uiHandler.showSnackBar(
                    'Something went wront! Please try again.',
                  );
                }
              },
              child: Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.only(left: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
