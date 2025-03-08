import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../typography/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextStyle? hintStyle;
  final bool? readOnly;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool isMultiLine;
  final String? errorText;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.contentPadding = const EdgeInsets.all(0),
    this.suffixIcon,
    this.obscureText = false,
    this.hintStyle,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.isMultiLine = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onChanged: onChanged,
        focusNode: focusNode,
        onTap: onTap,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        readOnly: readOnly ?? false,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? AppTextStyles.font14WeightRegular,
          contentPadding: contentPadding,
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Color(0xFFBABABA),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Color(0xFF5F33E1),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        keyboardType: isMultiLine ? TextInputType.multiline : keyboardType,
        maxLines: isMultiLine ? null : 1,
        // null allows unlimited lines
        minLines: isMultiLine ? 10 : 1,
        // Specify minimum lines for multi-line
        style: Theme.of(context).textTheme.labelLarge,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
