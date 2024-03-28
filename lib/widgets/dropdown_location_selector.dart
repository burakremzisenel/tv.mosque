import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_mosque/Model/location.dart';

import '../Logic/Provider/provider_settings.dart';

class DropDownLocationSelector extends StatefulWidget {
  DropDownLocationSelector({super.key});

  @override
  State<DropDownLocationSelector> createState() => DropDownLocationSelectorState();
}

class DropDownLocationSelectorState extends State<DropDownLocationSelector> {
  final FocusNode _dropdownFocusNode = FocusNode();

  @override
  void dispose() {
    _dropdownFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {

        List<Location> locations = [];
        Location? selectedLocation = provider.settings.location;
        if(selectedLocation != null){
          locations = provider.settings.countries
              .firstWhere((element) => element.name == selectedLocation.country).locations;
          locations.sort((a,b){
            // Sort by city
            int compareCity = (a.city).compareTo(b.city);
            if (compareCity != 0) {
              return compareCity;
            }

            if(a.isProvince != b.isProvince){
              if(b.isProvince){
                return -1;
              }
              return 1;
            }

            // Sort by name
            return a.province.compareTo(b.province);
          });
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
                    child: DropdownButton<Location>(
                      focusNode: _dropdownFocusNode,
                      value: selectedLocation,

                      // items
                      items: locations.map((location) => DropdownMenuItem<Location>(
                        value: location,
                        child: Text(location.isProvince? '${location.province} (${location.city})': location.city),
                      )).toList(),

                      // selected item builder
                      selectedItemBuilder: (context){
                        return locations.map((location) {
                          return Center(child: Text(location.isProvince? '${location.province} (${location.city})': location.city));
                        }).toList();
                      },

                      // on changed
                      onChanged: (Location? newValue) async{
                        if(newValue != null){
                          provider.updateLocation(newValue);
                        }
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
