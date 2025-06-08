import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PostFrameValueListenableBuilder<T> extends StatefulWidget {
  const PostFrameValueListenableBuilder({
    required this.valueListenable,
    required this.builder,
    super.key,
    this.child,
  });

  final ValueListenable<T> valueListenable;

  final ValueWidgetBuilder<T> builder;

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
