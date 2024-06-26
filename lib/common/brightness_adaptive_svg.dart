import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdaptiveBrightnessSvg extends StatelessWidget {
  const AdaptiveBrightnessSvg(this.assetName, {super.key});

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}
