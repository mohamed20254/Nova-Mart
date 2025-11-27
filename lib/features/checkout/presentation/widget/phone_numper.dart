import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumper extends StatelessWidget {
  const PhoneNumper({super.key});

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
          height: 40,
          width: 316,
          child: IntlPhoneField(
            dropdownTextStyle: Theme.of(context).textTheme.labelLarge,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
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
              print(phone.completeNumber); // +20xxxxxxxxx
            },
          ),
        ),
      ],
    );
  }
}
