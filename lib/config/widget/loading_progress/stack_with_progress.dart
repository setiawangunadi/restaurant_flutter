import 'package:flutter/material.dart';
import 'package:restaurant/config/widget/loading_progress/progress_custom.dart';
import 'package:restaurant/config/widget/loading_progress/shimmer_custom.dart';

class StackWithProgress extends StatelessWidget {
  const StackWithProgress({
    Key? key,
    required List<Widget> children,
    this.childShimmer,
    bool isLoading = false,
    this.opacity = 0.8,
  })  : _children = children,
        _isLoading = isLoading,
        super(key: key);
  final double opacity;
  final List<Widget> _children;
  final ShimmerCustom? childShimmer;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      _children.add(_progressBar(context));
    }

    return Stack(
      children: _children,
    );
  }

  Widget _progressBar(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: opacity,
          child: const ModalBarrier(
            dismissible: true,
            color: Colors.white,
          ),
        ),
        childShimmer != null
            ? childShimmer!
            : const ProgressCustom(color: Colors.grey),
      ],
    );
  }
}

class StackWithProgressTwo extends StatelessWidget {
  const StackWithProgressTwo({
    Key? key,
    required List<Widget> children,
    this.widgetLoading,
    bool isLoading = false,
    this.opacity = 0.8,
  })  : _children = children,
        _isLoading = isLoading,
        super(key: key);
  final double opacity;
  final List<Widget> _children;
  final Widget? widgetLoading;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      _children.add(_progressBar(context));
    }

    return Stack(
      children: _children,
    );
  }

  Widget _progressBar(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: opacity,
          child: const ModalBarrier(
            dismissible: true,
            color: Colors.white,
          ),
        ),
        widgetLoading != null ? widgetLoading! : const ProgressCustom(),
      ],
    );
  }
}
