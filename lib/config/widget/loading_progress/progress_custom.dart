import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressCustom extends StatelessWidget {
  final Color color;

  const ProgressCustom({
    super.key,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      )
          : const CupertinoActivityIndicator(),
    );
  }
}
