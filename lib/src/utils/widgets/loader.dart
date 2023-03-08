

import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppTheme.primary,strokeWidth:
      3,));
  }
}
