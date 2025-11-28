import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/checkout_buttom.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/dropdown_texfiled.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/phone_numper.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/shipping_textfiled.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Enter Shipping Details",
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          //full name
          const ShippingTextFiled(text: "Full Name *", hint: "Enter Full Name"),
          const SizedBox(height: 10),
          //phone Numper
          const PhoneNumper(),
          const SizedBox(height: 10),
          //slected province && City
          const Dropdown(),
          const SizedBox(height: 10),
          const ShippingTextFiled(
            text: "Street Adress *",
            hint: "Enter Street Adress",
          ),
          const SizedBox(height: 10),
          const ShippingTextFiled(
            text: "postal Code*",
            hint: "Enter postal code",
          ),
          const SizedBox(height: 60),
          CheckoutButtom(text: AppLocalizations.of(context)!.confirm),
        ],
      ),
    );
  }
}
