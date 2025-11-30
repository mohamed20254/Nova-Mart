import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CheckoutButtom extends StatelessWidget {
  const CheckoutButtom({super.key, required this.text, this.ontap});
  final String text;
  final void Function()? ontap;

  @override
  // ignore: prefer_final_parameters
  Widget build(BuildContext context) {
    final bool isdark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: ontap,
      child: SizedBox(
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
          onPressed: ontap,
          child: Text(
            AppLocalizations.of(context)!.confirm,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
