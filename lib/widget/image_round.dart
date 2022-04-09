import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class ImageRound extends StatelessWidget {

  final String? imagePath;
  final double? imageSize;
  final bool? editMode;
  final GestureTapCallback? onTap;

  ImageRound({
    this.imagePath,
    this.imageSize,
    this.editMode = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: editMode! ? onTap : null,
      child: ClipOval(
        child: Container(
          height: imageSize ?? 120,
          width: imageSize ?? 120,
          decoration: BoxDecoration(
            color: MtColor.paleBlack
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _imageProvider()
                    )
                  ),
                ),
              ),
              editMode! ? Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                height: 24,
                child: Container(
                  color: MtColor.grey,
                  alignment: Alignment.center,
                  child: Text(
                    '변경',
                    style: TextStyle(
                      color: MtColor.black,
                      fontWeight: FontWeight.w500,
                    )
                  )
                ),
              ) : Container(),
            ],
          )
        ),
      )
    );
  }

  ImageProvider _imageProvider(){
      return AssetImage(Asset.profile);
  }
}