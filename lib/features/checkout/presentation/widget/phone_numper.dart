import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumper extends StatefulWidget {
  const PhoneNumper({
    super.key,
    required this.controler,
    required this.keyfiled,
  });
  final TextEditingController controler;
  final GlobalKey<FormState> keyfiled;
  @override
  State<PhoneNumper> createState() => _PhoneNumperState();
}

class _PhoneNumperState extends State<PhoneNumper> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "  Phone Numper *",
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 316,
          //=============================Wrong
          // متسخدمش الباكدج دي تاني لا تدعم ال فاليدشن
          //=====================================
          child: IntlPhoneField(
            initialValue: FirebaseAuth.instance.currentUser!.phoneNumber ?? "",
            focusNode: focusNode,
            controller: widget.controler,
            // validator: (final phone) {
            //   if (phone == null || !phone.number.isNotEmpty) {
            //     return "numper required";
            //   }
            //   return null;
            // },
            dropdownTextStyle: Theme.of(context).textTheme.labelLarge,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
              counterText: '',
              fillColor: const Color(0xFFE7E3E3).withValues(alpha: 0.4),
              filled: true,
              isDense: true,
              contentPadding: const EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            initialCountryCode: 'EG',
            onChanged: (final phone) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
