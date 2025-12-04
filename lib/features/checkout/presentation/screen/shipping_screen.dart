import 'package:ecomerc_app_with_admin/core/helper/app_validate.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/checkout_buttom.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/dropdown_texfiled.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/phone_numper.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/shipping_textfiled.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({
    super.key,
    required this.onnext,
    required this.adressinfo,
    required this.customerInfo,
  });
  final Function(int) onnext;
  final Function(AddressInfo) adressinfo;
  final Function(CustomerInfo) customerInfo;

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  late final TextEditingController nameControler;
  late final TextEditingController phoneContoler;
  late final TextEditingController streetcontroler;
  late final TextEditingController posalcode;
  final GlobalKey<FormState> formsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> keyfiled = GlobalKey<FormState>();
  String city = "";
  String governorate = "";
  @override
  void initState() {
    nameControler = TextEditingController();
    phoneContoler = TextEditingController();
    streetcontroler = TextEditingController();
    posalcode = TextEditingController();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formsKey,
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
            ShippingTextFiled(
              controler: nameControler,
              text: "Full Name *",
              hint: "Enter Full Name",
              validator: AppValidators.validateName,
            ),
            const SizedBox(height: 10),
            //phone Numper
            PhoneNumper(controler: phoneContoler, keyfiled: keyfiled),
            const SizedBox(height: 10),
            //slected province && City
            Dropdown(
              onCity: (final childcity) {
                setState(() {
                  city = childcity;
                });
              },
              onGovernorate: (final childgovernorate) {
                setState(() {
                  governorate = childgovernorate;
                });
              },
            ),
            const SizedBox(height: 10),
            //==============street Adress
            ShippingTextFiled(
              validator: AppValidators.validStreet,
              controler: streetcontroler,
              text: "Street Adress *",
              hint: "Enter Street Adress",
            ),
            const SizedBox(height: 10),
            //====================zipcode
            ShippingTextFiled(
              validator: AppValidators.validPostalCode,
              controler: posalcode,
              text: "postal Code*",
              hint: "Enter postal code",
            ),
            const SizedBox(height: 60),
            CheckoutButtom(
              text: AppLocalizations.of(context)!.confirm,
              ontap: () {
                if (formsKey.currentState!.validate()) {
                  widget.onnext(1);
                  widget.adressinfo(
                    AddressInfo(
                      city: city,
                      area: governorate,
                      addressLine1: streetcontroler.text,
                      postalCode: double.tryParse(posalcode.text) ?? 0,
                      lng: 0,
                    ),
                  );
                  widget.customerInfo(
                    CustomerInfo(
                      name: nameControler.text,
                      phone: nameControler.text,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
