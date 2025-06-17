import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A widget that rebuilds when the given [ValueListenable] changes,
/// but ensures the rebuild happens in a post-frame callback.
///
/// This is useful when you want to delay the rebuild until
/// after the current frame, avoiding layout-related exceptions or
/// flickering issues during widget updates.
@Deprecated('Currently not used')
class PostFrameValueListenableBuilder<T> extends StatefulWidget {
  /// Creates a [PostFrameValueListenableBuilder] widget.
  @Deprecated('Currently not used')
  const PostFrameValueListenableBuilder({
    required this.valueListenable,
    required this.builder,
    super.key,
    this.child,
  });

  /// The listenable object to which this widget subscribes.
  ///
  /// Whenever the value changes, the builder will be called
  /// in a post-frame callback.
  final ValueListenable<T> valueListenable;

  /// Called whenever the [valueListenable] changes.
  ///
  /// The builder is provided with the current context, the latest value,
  /// and an optional child widget.
  final ValueWidgetBuilder<T> builder;

  /// A constant child widget that does not depend on the [valueListenable].
  ///
  /// This child is passed back to the [builder] and helps optimize performance.
  final Widget? child;

  @override
  State<StatefulWidget> createState() =>
      _PostFrameValueListenableBuilderState<T>();
}

class _PostFrameValueListenableBuilderState<T>
    extends State<PostFrameValueListenableBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(PostFrameValueListenableBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  /// Handles updates from the [ValueListenable] by scheduling a
  /// rebuild using [WidgetsBinding.addPostFrameCallback].
  void _valueChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => value = widget.valueListenable.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
