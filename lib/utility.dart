import 'package:flutter/material.dart';

showSnackBar(dynamic messenger,
    {String? txt, Color? color, bool showAction = false, String? actionName, Function()? onTap, bool allowDismiss = true, Duration duration = const Duration(seconds: 4)}) {
  messenger.showSnackBar(
    SnackBar(
      dismissDirection: allowDismiss ? DismissDirection.down : DismissDirection.none,
      duration: duration,
      content: Text(txt ?? "Something went wrong"),
      backgroundColor: color ?? Colors.red,
      action: showAction && actionName != null && onTap != null
          ? SnackBarAction(
              label: actionName,
              onPressed: onTap,
              textColor: Colors.white,
            )
          : null,
    ),
  );
}
