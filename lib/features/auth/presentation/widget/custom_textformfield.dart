import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final String label;
  final Widget? prefixicon;
  final bool obsqurtext;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const MyTextFormField({
    this.controller,
    this.validator,
    super.key,
    required this.label,
    this.prefixicon,
    this.obsqurtext = false,

    required this.keyboardType,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool showpass = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
      controller: widget.controller,
      validator: widget.validator,
      obscureText: showpass && widget.obsqurtext,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        prefixIcon: widget.prefixicon,
        suffixIcon: widget.obsqurtext
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showpass = !showpass;
                  });
                },
                icon: Icon(showpass ? Icons.visibility : Icons.visibility_off),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppTheme.isdark(context) ? Colors.white60 : Colors.black54,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
