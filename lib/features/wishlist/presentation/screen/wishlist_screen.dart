import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/custome_gride_view.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.wishlist,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      // body: CustomeGrideView(),
    );
  }
}
