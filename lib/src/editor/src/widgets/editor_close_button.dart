import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../assets/icons/custom_icons.dart';
import '../../../../kush_gallery_picker.dart';
import '../../../animations/animations.dart';
import '../../../camera/src/widgets/ui_handler.dart';
import 'editor_builder.dart';

///
class EditorCloseButton extends StatelessWidget {
  ///
  const EditorCloseButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  ///
  final KushEditingController controller;

  Future<bool> _onPressed(BuildContext context, {bool pop = true}) async {
    if (!controller.value.hasStickers) {
      if (pop) {
        Navigator.of(context).pop();
      }
      //  else {
      //   await UIHandler.showStatusBar();
      // }
      return true;
    } else {
      await showDialog<bool>(
        context: context,
        builder: (context) => const _AppDialog(),
      ).then((value) {
        if (value ?? false) {
          controller.clear();
        }
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPressed(context, pop: false),
      child: EditorBuilder(
        controller: controller,
        builder: (context, value, child) {
          final crossFadeState = value.isEditing || value.hasFocus
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond;
          return AppAnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: child!,
            crossFadeState: crossFadeState,
          );
        },
        child: InkWell(
          onTap: () {
            _onPressed(context);
          },
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
      ),
    );
  }
}

class _AppDialog extends StatelessWidget {
  const _AppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cancel = TextButton(
      onPressed: Navigator.of(context).pop,
      child: Text(
        'NO',
        style: Theme.of(context).textTheme.button!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
    final unselectItems = TextButton(
      onPressed: () {
        Navigator.of(context).pop(true);
      },
      child: Text(
        'DISCARD',
        style: Theme.of(context).textTheme.button!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );

    return AlertDialog(
      title: Text(
        'Discard changes?',
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white70,
            ),
      ),
      content: Text(
        'Are you sure you want to discard your changes?',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.grey.shade600,
            ),
      ),
      actions: [cancel, unselectItems],
      backgroundColor: Colors.grey.shade900,
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
    );
  }
}
