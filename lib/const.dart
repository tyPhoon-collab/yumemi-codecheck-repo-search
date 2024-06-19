import 'package:flutter/material.dart';

class SvgAssets {
  static const String _basePath = 'assets/image/svg';

  static const String repo = '$_basePath/repo.svg';
  static const String fork = '$_basePath/repo-forked.svg';
  static const String issue = '$_basePath/issue-opened.svg';
  static const String star = '$_basePath/star.svg';
  static const String watch = '$_basePath/eye.svg';
  static const String code = '$_basePath/file-code.svg';
  static const String clock = '$_basePath/clock.svg';
  static const String history = '$_basePath/history.svg';
}

class AnimationData {
  const AnimationData({required this.duration, required this.curve});

  final Duration duration;
  final Curve curve;
}

class Animations {
  static const searched = AnimationData(
    duration: Durations.medium3,
    curve: Curves.easeInOutQuart,
  );
}
