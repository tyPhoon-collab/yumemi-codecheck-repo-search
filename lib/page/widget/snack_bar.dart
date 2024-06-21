import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    required this.label,
    required this.showCloseIcon,
    super.key,
  });

  const CustomSnackBar.info({
    required this.label,
    super.key,
  }) : showCloseIcon = true;

  const CustomSnackBar.error({
    required this.label,
    super.key,
  }) : showCloseIcon = false;

  // https://m3.material.io/components/snackbar/guidelines
  // ガイドラインを参照すると、SnackBarには文字列だけが推奨されている
  final String label;
  final bool showCloseIcon;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(label),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: showCloseIcon,
    );
  }
}
