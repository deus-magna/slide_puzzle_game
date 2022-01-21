import 'dart:ui';

extension Factor on double {
  double scale(Size size) => size.height < 700 ? this * 0.7 : this * 1.0;
}
