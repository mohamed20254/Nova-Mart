import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

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
    String jsonString = await rootBundle.loadString('assets/json/country.json');
    setState(() {
      data = json.decode(jsonString);
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 316,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE7E3E3).withValues(alpha: 0.4),
              hint: Text(
                "Select Governorate",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
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
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        // Dropdown للمدينة
        SizedBox(
          height: 40,
          width: 316,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hint: Text(
                "Select City",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
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
              });
            },
          ),
        ),
      ],
    );
  }
}
