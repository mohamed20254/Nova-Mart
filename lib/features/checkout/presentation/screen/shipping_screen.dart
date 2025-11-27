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
    final bool isdark = Theme.of(context).brightness == Brightness.dark;
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
          SizedBox(
            height: 47,
            width: 272,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: isdark ? Colors.white : Colors.black,
                elevation: 2,

                backgroundColor: isdark ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(18),
                ),
              ),
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.confirm,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
