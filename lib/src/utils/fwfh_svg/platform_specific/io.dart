import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';

BytesLoader? filePicture(
    String path,
    ) =>
    SvgFileLoader(File(path));