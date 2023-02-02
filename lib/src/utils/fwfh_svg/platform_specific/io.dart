import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';

SvgLoader? svgFileLoader(
    String path,
    ) =>
    SvgFileLoader(File(path));