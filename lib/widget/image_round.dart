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
      child: SizedBox(
        height: imageSize ?? 110,
        width: imageSize ?? 110,
        child: Stack(
          children: [
            ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  color: MtColor.paleBlack
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _imageProvider()
                    )
                  ),
                )
              ),
            ),
            editMode == true ? Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: MtColor.paleGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: MtColor.grey,
                  size: 25
                ),
              ),
            ) : Container(),
          ],
        ),
      )
    );
  }

  ImageProvider _imageProvider(){
      return AssetImage(Asset.profile);
  }
}