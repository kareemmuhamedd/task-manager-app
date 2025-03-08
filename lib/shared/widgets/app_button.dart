import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.appButtonWidget,
    required this.onPressed,
    this.appButtonColor = AppColors.primaryColor,
    this.isInProgress = false,
  });

  final Widget appButtonWidget;
  final Color appButtonColor;
  final VoidCallback onPressed;
  final bool isInProgress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //margin: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          color: appButtonColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: isInProgress
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.whiteColor,
                      strokeWidth: 2,
                      strokeCap: StrokeCap.butt,
                    ),
                  )
                : appButtonWidget,
          ),
        ),
      ),
    );
  }
}
