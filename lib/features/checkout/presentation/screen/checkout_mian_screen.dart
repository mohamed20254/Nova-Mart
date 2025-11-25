import 'package:ecomerc_app_with_admin/features/checkout/presentation/screen/shipping_screen.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/checkot_appbar.dart';
import 'package:flutter/material.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

class CheckoutMianScreen extends StatefulWidget {
  const CheckoutMianScreen({super.key});

  @override
  State<CheckoutMianScreen> createState() => _CheckoutMianScreenState();
}

class _CheckoutMianScreenState extends State<CheckoutMianScreen> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: ceckOutAppbar(context),
      body: Column(
        children: [
          SizedBox(height: 10),
          buildHeader(context),
          SizedBox(height: 10),
          ShippingScreen(),
        ],
      ),
    );
  }

  Center buildHeader(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 280,
        child: Row(
          children: [
            customcolumn(context, text: "Shipping", icon: Iconsax.ship_copy),
            const SizedBox(width: 47, child: Divider(color: Colors.black)),
            customcolumn(
              context,
              text: "payment",
              icon: Icons.payment_outlined,
            ),
            const SizedBox(width: 47, child: Divider(color: Colors.black)),
            customcolumn(context, text: "Review", icon: Icons.reviews_outlined),
          ],
        ),
      ),
    );
  }

  Column customcolumn(
    BuildContext context, {
    required final String text,
    required final IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon),
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
