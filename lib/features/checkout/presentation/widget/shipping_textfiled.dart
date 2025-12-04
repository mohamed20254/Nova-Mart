import 'package:flutter/material.dart';

class ShippingTextFiled extends StatelessWidget {
  const ShippingTextFiled({
    super.key,
    required this.text,
    required this.hint,
    this.prefix,
    this.validator,
    required this.controler,
  });
  final String text;
  final String hint;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final TextEditingController controler;
  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "  $text",
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5),
          Container(
            width: 316,

            child: TextFormField(
              controller: controler,
              validator: validator,

              style: Theme.of(context).textTheme.labelLarge,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: const Color(0xFFE7E3E3).withValues(alpha: 0.4),
                filled: true,
                errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),

                hintText: hint,
                hintStyle: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w300),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
