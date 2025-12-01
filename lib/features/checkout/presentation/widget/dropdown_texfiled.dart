import 'dart:convert';

import 'package:ecomerc_app_with_admin/core/helper/app_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({
    super.key,
    required this.onGovernorate,
    required this.onCity,
  });
  final Function(String) onGovernorate;
  final Function(String) onCity;
  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  Map<String, dynamic> data = {};
  String? selectedGovernorate;
  String? selectedCity;
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String jsonString = await rootBundle.loadString(
      'assets/json/country.json',
    );
    setState(() {
      data = json.decode(jsonString);
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 316,
          child: DropdownButtonFormField<String>(
            validator: AppValidators.validStreet,
            isExpanded: true,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
              filled: true,
              fillColor: const Color(0xFFE7E3E3).withValues(alpha: 0.4),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hint: Transform.translate(
                offset: const Offset(10, -15),
                child: Text(
                  "Select Governorate",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
              ),

              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            initialValue: selectedGovernorate,
            items: data.keys
                .map(
                  (final gov) => DropdownMenuItem(
                    value: gov,
                    child: Text(
                      gov,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (final value) {
              setState(() {
                selectedGovernorate = value;
                cities = List<String>.from(data[value]!);
                selectedCity = null;
                widget.onGovernorate(value ?? "");
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        // Dropdown للمدينة
        SizedBox(
          width: 316,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            validator: AppValidators.validStreet,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
              hint: Transform.translate(
                offset: const Offset(10, -15),
                child: Text(
                  "Select City",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              filled: true,
              isDense: true,

              fillColor: const Color(0xFFE7E3E3).withValues(alpha: 0.4),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            initialValue: selectedCity,
            items: cities
                .map(
                  (final city) => DropdownMenuItem(
                    value: city,
                    child: Text(
                      city,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (final value) {
              setState(() {
                selectedCity = value;
                widget.onCity(value ?? "");
              });
            },
          ),
        ),
      ],
    );
  }
}
