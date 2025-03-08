import 'package:flutter/material.dart';
import 'package:management_tasks_app/shared/typography/app_font_weight.dart';

import '../theme/app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle font24WeightBold = TextStyle(
    fontSize: 24,
    fontWeight: AppFontWeight.bold,
    color: AppColors.blackColor,
  );

  static const TextStyle font14WeightRegular = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textGreyColor,
  );
  static const TextStyle font14WeightMedium = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
    color: AppColors.textBlackColor,
  );
  static const TextStyle font19WeightBold = TextStyle(
    fontSize: 19,
    fontWeight: AppFontWeight.bold,
    color: AppColors.whiteColor,
  );
  static const TextStyle font19WeightMedium = TextStyle(
    fontSize: 19,
    fontWeight: AppFontWeight.bold,
    color: AppColors.whiteColor,
  );
  static const TextStyle font17WeightBold = TextStyle(
    fontSize: 17,
    fontWeight: AppFontWeight.bold,
    color: AppColors.textGreyColor2,
  );
  static const TextStyle font18WeightBold = TextStyle(
    fontSize: 18,
    fontWeight: AppFontWeight.bold,
    color: AppColors.blackColor,
  );
  static const TextStyle font16WeightBold = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.bold,
    color: AppColors.whiteColor,
  );
  static const TextStyle font16WeightRegular = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
  );
  static const TextStyle font14WeightBold = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.bold,
    color: AppColors.textGreyColor2,
  );
  static const TextStyle font12WeightMedium = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.medium,
  );
  static const TextStyle font12WeightRegular = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
  );
  static const TextStyle font9WeightRegular = TextStyle(
    fontSize: 9,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textGreyColor,
  );
}
