import 'package:flutter/material.dart';

class ShippingTextFiled extends StatelessWidget {
  const ShippingTextFiled({
    super.key,
    required this.text,
    required this.hint,
    this.prefix,
  });
  final String text;
  final String hint;
  final Widget? prefix;
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
            decoration: BoxDecoration(
              color: Color(0xFFE7E3E3).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),

            width: 316,
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(0),
                      hintText: hint,
                      hintStyle: Theme.of(context).textTheme.labelMedium!
                          .copyWith(fontWeight: FontWeight.w300),

                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
