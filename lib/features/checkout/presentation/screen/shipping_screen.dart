import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/phone_numper.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/shipping_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        Text(
          "Enter Shipping Details",
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        const ShippingTextFiled(text: "Full Name *", hint: "Enter Full Name"),
        const SizedBox(height: 10),

        const PhoneNumper(),
      ],
    );
  }
}
