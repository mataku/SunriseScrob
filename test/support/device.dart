// ref. https://github.com/Betterment/alchemist/issues/37

import 'package:flutter/material.dart';

class Device {
  /// [name] specify device name. Ex: Phone, Tablet, Watch
  final String name;

  /// [size] specify device screen size. Ex: Size(1366, 1024))
  final Size size;

  /// [devicePixelRatio] specify device Pixel Ratio
  final double devicePixelRatio;

  /// [textScaleFactor] specify custom text scale factor
  final double textScaleFactor;

  /// [brightness] specify platform brightness
  final Brightness brightness;

  /// [safeArea] specify insets to define a safe area
  final EdgeInsets safeArea;

  const Device({
    required this.size,
    required this.name,
    this.devicePixelRatio = 1.0,
    this.textScaleFactor = 1.0,
    this.brightness = Brightness.light,
    this.safeArea = const EdgeInsets.all(0),
  });

  /// [copyWith] convenience function for [Device] modification
  Device copyWith({
    Size? size,
    double? devicePixelRatio,
    String? name,
    double? textScale,
    Brightness? brightness,
    EdgeInsets? safeArea,
  }) {
    return Device(
      size: size ?? this.size,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      name: name ?? this.name,
      textScaleFactor: textScale ?? textScaleFactor,
      brightness: brightness ?? this.brightness,
      safeArea: safeArea ?? this.safeArea,
    );
  }

  @override
  String toString() {
    return 'Device: $name, '
        '${size.width}x${size.height} @ $devicePixelRatio, '
        'text: $textScaleFactor, $brightness, safe: $safeArea';
  }

  /// [dark] convenience method to copy the current device and apply dark theme
  Device dark() {
    return Device(
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
      brightness: Brightness.dark,
      safeArea: safeArea,
      name: '${name}_dark',
    );
  }

  static const Device iPhone15Pro = Device(
    name: 'iPhone15Pro',
    size: Size(393, 852),
    devicePixelRatio: 1.0,
    safeArea: EdgeInsets.only(top: 44, bottom: 34),
  );

  static const Device iPadPro11Landscape = Device(
    name: 'iPadPro11Landscape',
    size: Size(1210, 834),
    devicePixelRatio: 1.0,
    safeArea: EdgeInsets.only(top: 44, bottom: 34),
  );

  static List<Device> lightTargets = [
    iPhone15Pro,
    iPadPro11Landscape,
  ];

  static List<Device> darkTargets = [
    iPhone15Pro.dark(),
    iPadPro11Landscape.dark(),
  ];
}
