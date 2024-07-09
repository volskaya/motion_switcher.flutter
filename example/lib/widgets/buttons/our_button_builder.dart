import 'dart:async';

import 'package:app/extensions/state.dart';
import 'package:flutter/material.dart';

typedef OurButtonCallback = FutureOr<void> Function();
typedef OurButtonBuilderCallback = Widget Function(
    BuildContext context, bool isPressed, bool isLoading, bool isDisabled);

/// This serves as base for our button widgets, handling
/// the gesture detection and async callback state.
class OurButtonBuilder extends StatefulWidget {
  const OurButtonBuilder({
    super.key,
    required this.onTap,
    required this.builder,
  });

  final OurButtonCallback? onTap;
  final OurButtonBuilderCallback builder;

  @override
  State<OurButtonBuilder> createState() => _OurButtonBuilderState();
}

class _OurButtonBuilderState extends State<OurButtonBuilder> {
  bool _isPressed = false;
  bool _isLoading = false;
  Future<void>? _activeFuture;

  void _handleTap() {
    if (_isLoading || _activeFuture != null || widget.onTap == null) return;
    _isLoading = true;
    _activeFuture = Future(() async {
      try {
        await widget.onTap?.call();
      } finally {
        if (mounted) {
          _activeFuture = null;
          _isLoading = false;
          markNeedsBuild();
        }
      }
    });
    markNeedsBuild();
  }

  @override
  void dispose() {
    _activeFuture?.ignore();
    _activeFuture = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onTap == null;

    return GestureDetector(
      onTapDown: !isDisabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: !isDisabled ? _handleTap : null,
      child: widget.builder(context, !_isLoading ? _isPressed : false, _isLoading, isDisabled),
    );
  }
}
