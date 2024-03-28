

import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_mosque/Logic/Provider/provider_settings.dart';
import 'package:tv_mosque/Model/location.dart';

import '../Model/country.dart';

class DropDownCountrySelector extends StatefulWidget {
  DropDownCountrySelector({super.key});

  @override
  State<DropDownCountrySelector> createState() => _DropDownCountrySelectorState();
}

class _DropDownCountrySelectorState extends State<DropDownCountrySelector> {
  final FocusNode _dropdownFocusNode = FocusNode();

  @override
  void dispose() {
    _dropdownFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Flag flagBuilder(String countryCode){
      if(countryCode == 'EN'){
        countryCode = 'GB';
      }
      return Flag.fromString(
        countryCode,
        height: 30,
        width: 40,
        fit: BoxFit.fitHeight,
        flagSize: FlagSize.size_4x3,
        borderRadius: 3,
      );
    }

    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {

        final List<Country> countries = provider.settings.countries;

        List<Flag> dropdownFlags = [];
        for(var country in countries){
          dropdownFlags.add(flagBuilder(country.name));
        }

        String? selectedCountryName = provider.settings.location?.country;
        if(selectedCountryName == 'EN'){
          selectedCountryName = 'GB';
        }

        return Focus(
          child: Builder(
            builder: (context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return Container(
                padding: const EdgeInsets.all(10),
                /// Decoration
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: hasFocus? Colors.redAccent: Colors.white24,
                      blurRadius: 5.0,
                      spreadRadius: 0.2,
                    ),
                    const BoxShadow(
                      color: Colors.black38,
                      blurRadius: 15.0,
                      spreadRadius: -15.0,
                    )
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusNode: _dropdownFocusNode,
                    value: selectedCountryName,

                    // items
                    items: dropdownFlags.map((flag) => DropdownMenuItem<String>(
                      value: flag.country.toUpperCase(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // flag
                            flag,
                            // country code
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                flag.country.toUpperCase(),
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          ]
                      ),
                    )).toList(),

                    // on changed
                    onChanged: (String? newValue) async{
                      if(newValue == 'GB'){
                        newValue = 'EN';
                      }
                      /// Set country & first location in the locations list of country
                      Location location = countries.firstWhere((element) => element.name == newValue).locations.first;
                      provider.updateLocation(location);
                    },

                    style: const TextStyle(color: Colors.black), // Textfarbe anpassen
                    dropdownColor: Colors.white, // Hintergrundfarbe des Dropdown-Menüs anpassen
                    icon: const Icon(Icons.arrow_drop_down), // Dropdown-Icon anpassen
                    iconSize: 24, // Größe des Dropdown-Icons anpassen
                    elevation: 16, // Schatten anpassen
                    isExpanded: true,
                    isDense: true,
                    autofocus: true,
                  ),
                ),
              );
            }
          ),
        );
      }
    );
  }
}
