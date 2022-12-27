import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({super.key,
    this.controller,
    this.error,
    this.suffixIcon,
    this.iconPrefix,
    this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.errorText,
    this.minLines = 1,
    this.showCursor,
    this.autoFocus,
    this.maxLines,
    this.hintText,
    this.readOnly,
    this.onChanged,
    this.maxLength,
    this.style,
    this.onSaved,
    this.upperCaseFirstLetter,
  });

  final TextEditingController? controller;
  final Widget? iconPrefix;
  final Widget? suffixIcon;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? hintText;
  final String? errorText;
  final TextStyle? style;
  final bool? showCursor;
  final int? maxLength;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? error;
  final bool? upperCaseFirstLetter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textAlignVertical: TextAlignVertical.center,
      readOnly: readOnly ?? false,
      autofocus: autoFocus ?? false,
      maxLength: maxLength,
      showCursor: showCursor,
      textCapitalization: upperCaseFirstLetter == true ? TextCapitalization.sentences : TextCapitalization.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: style ?? Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          focusedBorder: error == true ? Theme.of(context).inputDecorationTheme.errorBorder : null,
          contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          hintMaxLines: 1,
          suffixIcon: suffixIcon,
          counterText: '',
          errorText: errorText,
          filled: true,
          // isDense: true,
          errorMaxLines: 1,
          fillColor: readOnly == true ? Theme.of(context).disabledColor : null,
          prefixIcon: iconPrefix,
          labelText: labelText,
          hintText: hintText),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
    );
  }
}
