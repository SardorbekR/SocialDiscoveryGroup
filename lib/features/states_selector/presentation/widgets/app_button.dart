import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback onTap;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
    this.buttonText,
    this.leading,
    this.trailing,
    this.margin,
    this.textStyle,
    this.borderColor,
    this.padding,
    this.borderRadius = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        excludeFromSemantics: true,
        child: Container(
          margin: margin,
          height: 48,
          padding: padding ?? const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null ? Border.all(color: borderColor!) : null,
            color: backgroundColor,
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (leading != null) leading!,
              const SizedBox(width: 10.0),
              Text(
                buttonText ?? '',
                style: textStyle,
              ),
              const SizedBox(width: 10.0),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
