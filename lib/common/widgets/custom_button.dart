import 'package:flutter/material.dart';
import 'package:flutter_developer_test/common/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 120.w,
      height: height ?? 50.h,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color ?? AppColors.mainColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: CircularProgressIndicator()))
            : Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
      ),
    );
  }
}
