import 'package:flutter/cupertino.dart';

import '../utils/app_enums.dart';
import '../utils/extensions.dart';

class CustomImageView extends StatelessWidget {
  final String imagePath;
  final ImageType _imageType;
  final FileType _fileType;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final String placeHolder;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;

  CustomImageView({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  })  : assert(imagePath.imageType != ImageType.other),
        _imageType = imagePath.imageType,
        _fileType = imagePath.fileType;

  @override
  Widget build(BuildContext context) {
    return switch (_imageType) {
      ImageType.png => Image(image: _fileType == FileType.asset ? AssetImage(imagePath) : NetworkImage(imagePath)),
      _ => throw UnimplementedError(),
    };
  }
}
