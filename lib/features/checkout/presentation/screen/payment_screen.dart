import 'package:ecomerc_app_with_admin/core/constant/app_icons.dart';
import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/checkout_buttom.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.onnext});
  final Function(int) onnext;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ValueNotifier<String> currentPayment = ValueNotifier(AppStrings.creditcard);

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: currentPayment,
          builder: (final context, final value, final child) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Select a Payment Mehod",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                customSelectedPayment(
                  context,
                  image: AppIcons.creditCard,
                  onChanged: (final value) {},
                  title: "Credit Card",
                  value: value.contains(AppStrings.creditcard),
                  ontap: () {
                    currentPayment.value = AppStrings.creditcard;
                  },
                ),
                const SizedBox(height: 10),
                customSelectedPayment(
                  context,
                  image: AppIcons.paypal,
                  onChanged: (final value) {},
                  title: "Paypal",
                  value: value.contains(AppStrings.paypal),
                  ontap: () {
                    currentPayment.value = AppStrings.paypal;
                  },
                ),
                const SizedBox(height: 10),
                customSelectedPayment(
                  context,
                  image: AppIcons.cash,
                  onChanged: (final value) {},
                  title: "Cash Collection",
                  value: value.contains(AppStrings.cash),
                  ontap: () {
                    currentPayment.value = AppStrings.cash;
                  },
                ),
                const SizedBox(height: 270),

                CheckoutButtom(
                  text: AppLocalizations.of(context)!.confirm,
                  ontap: () {
                    widget.onnext(2);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SizedBox customSelectedPayment(
    final BuildContext context, {
    required final String image,
    required final bool value,
    required final String title,
    required final void Function(bool?) onChanged,
    required final void Function() ontap,
  }) {
    return SizedBox(
      height: 55,
      width: 300,
      child: InkWell(
        onTap: ontap,
        child: Row(
          children: [
            Container(
              height: 45,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),

                boxShadow: const [
                  BoxShadow(blurRadius: 1, offset: Offset(0, 2)),
                ],
              ),
              child: Image.asset(image, height: 31, fit: BoxFit.contain),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            RadioGroup(
              onChanged: onChanged,
              groupValue: true,
              child: Radio(
                value: value,

                focusColor: Colors.black,
                fillColor: WidgetStateProperty.all(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
