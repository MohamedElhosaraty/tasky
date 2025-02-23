import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/app_color.dart';


class CustomEditeImage extends StatefulWidget {
  const CustomEditeImage({
    super.key,
    required this.onImageSelected, required this.image,
  });

  final ValueChanged<String?> onImageSelected;
  final String image;

  @override
  State<CustomEditeImage> createState() => _CustomEditeImageState();
}

class _CustomEditeImageState extends State<CustomEditeImage> {
  File? taskImage;

  Future<void> pickTaskImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? imagePicked = await picker.pickImage(source: source);

      if (imagePicked != null) {
        setState(() {
          taskImage = File(imagePicked.path);
        });
        widget.onImageSelected(taskImage!.path);
      } else {
        log('No media files were selected.');
      }
    } catch (e) {
      log('An error ImagePickedFailure while picking media files.');
    }
  }

  pickTaskImageBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          height: 200.h,
          width: double.infinity,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickTaskImage(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 50,
                    color: AppColor.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickTaskImage(ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 50,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height:  200.h,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color(0xff949D9E),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: () async {
          pickTaskImageBottomSheet(context);
        },
        child: Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: FileImage(
                taskImage == null ? File(widget.image) : taskImage!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
