import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../kush_gallery_picker.dart';

///
class PhotoEditingControllerProvider extends InheritedWidget {
  /// Creates a widget that associates a [KushEditingController] with a
  /// subtree.
  const PhotoEditingControllerProvider({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  /// Creates a subtree without an associated [KushEditingController].
  const PhotoEditingControllerProvider.none({
    Key? key,
    required Widget child,
  })  : controller = null,
        super(key: key, child: child);

  /// The [KushEditingController] associated with the subtree.
  ///
  final KushEditingController? controller;

  /// Returns the [KushEditingController] most closely associated
  /// with the given context.
  ///
  /// Returns null if there is no [KushEditingController] associated with the
  /// given context.
  static KushEditingController? of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<PhotoEditingControllerProvider>();
    return result?.controller;
  }

  @override
  bool updateShouldNotify(covariant PhotoEditingControllerProvider oldWidget) =>
      controller != oldWidget.controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<KushEditingController>(
        'controller',
        controller,
        ifNull: 'no controller',
        showName: false,
      ),
    );
  }
}

///
extension PlaygroundControllerProviderExtension on BuildContext {
  /// [KushEditingController] instance
  KushEditingController? get photoEditingController =>
      PhotoEditingControllerProvider.of(this);
}
