import 'package:ecomerc_app_with_admin/features/checkout/presentation/screen/payment_screen.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/screen/review_screen.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/screen/shipping_screen.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/checkot_appbar.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CheckoutMianScreen extends StatefulWidget {
  const CheckoutMianScreen({super.key, required this.orders});
  final List<OrderItem> orders;

  @override
  State<CheckoutMianScreen> createState() => _CheckoutMianScreenState();
}

class _CheckoutMianScreenState extends State<CheckoutMianScreen> {
  ValueNotifier<int> cuurentpage = ValueNotifier(0);
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: ceckOutAppbar(context),
      body: Column(
        children: [
          const SizedBox(height: 10),
          buildHeader(context),
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: cuurentpage,
            builder: (context, value, child) {
              if (value == 0) {
                return Expanded(
                  child: ShippingScreen(
                    onnext: (final index) {
                      cuurentpage.value = index;
                    },
                  ),
                );
              } else if (value == 1) {
                return PaymentScreen(
                  onnext: (final index) {
                    cuurentpage.value = index;
                  },
                );
              } else if (value == 2) {
                return Expanded(child: ReviewScreen(orders: widget.orders));
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Center buildHeader(final BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 280,
        child: ValueListenableBuilder(
          valueListenable: cuurentpage,
          builder: (context, value, child) {
            return Row(
              children: [
                //    Shiping screen
                customcolumn(
                  context,
                  text: "Shipping",
                  icon: value > 0 ? Iconsax.ship : Iconsax.ship_copy,
                  color: value >= 0 ? Colors.black : Colors.grey,
                ),
                const SizedBox(width: 47, child: Divider(color: Colors.black)),

                //         pament screen
                customcolumn(
                  context,
                  text: "payment",
                  icon: value > 1 ? Iconsax.card_edit : Icons.payment_outlined,
                  color: value >= 1 ? Colors.black : Colors.grey,
                ),
                const SizedBox(width: 47, child: Divider(color: Colors.black)),

                //       review screen
                customcolumn(
                  context,
                  text: "Review",
                  icon: Icons.reviews_outlined,
                  color: value == 2 ? Colors.black : Colors.grey,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Column customcolumn(
    final BuildContext context, {
    required final String text,
    required final IconData icon,
    required final Color color,
    final Color? textcolor,
  }) {
    return Column(
      children: [
        Icon(icon, color: color),
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: textcolor,
            fontWeight: FontWeight.w500,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
