import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

AppBar ceckOutAppbar(final BuildContext context) {
  return AppBar(
    title: Text(
      "Checkout",
      style: Theme.of(context).textTheme.bodySmall!.copyWith(letterSpacing: 2),
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 33,
          width: 33,
          child: Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.shopping_cart_copy, size: 26),
              ),
              const Positioned(
                top: 8,
                right: 0,

                child: CircleAvatar(backgroundColor: Colors.red, radius: 4),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
