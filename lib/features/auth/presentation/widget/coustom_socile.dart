import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

Container customSocil(BuildContext context, {Widget? child}) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: AppTheme.isdark(context) ? Colors.white : Colors.black,
      ),
    ),
    child: child,
  );
}
