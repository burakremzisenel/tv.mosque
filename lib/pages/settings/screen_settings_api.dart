import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:auto_route/annotations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tv_mosque/helper/extensions.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'package:iconify_flutter/icons/fa_solid.dart';
import '../../Logic/Provider/provider_settings.dart';

import 'package:iconify_flutter/icons/carbon.dart';
import 'package:adhan/adhan.dart';

@RoutePage()
class ApiSettingsPage extends StatefulWidget {
  const ApiSettingsPage({super.key});

  @override
  State<ApiSettingsPage> createState() => ApiSettingsPageState();
}

class ApiSettingsPageState extends State<ApiSettingsPage> {

  /// Text input field controllers
  final Map<String, TextEditingController> ctrlMap = {
    'igmg_api': TextEditingController(),
    'igmg_token': TextEditingController(),
    'directus_api': TextEditingController(),
    'directus_token': TextEditingController(),
  };

  /// Focus nodes
  final Map<String, FocusNode> fcMap = {
    'igmg_api': FocusNode(),
    'igmg_token': FocusNode(),
    'directus_api': FocusNode(),
    'directus_token': FocusNode(),
  };

  final FocusNode _FC1 = FocusNode();
  final FocusNode _FC2 = FocusNode();
  final FocusNode _FC3 = FocusNode();


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Read settings from provider
    SettingsProvider? provider  = Provider.of<SettingsProvider?>(context);
    if(provider != null){
      ctrlMap['igmg_api']!.text = provider.settings.igmgApi;
      ctrlMap['igmg_token']!.text = provider.settings.igmgApiKey;
      ctrlMap['directus_api']!.text = provider.settings.directusApi;
      ctrlMap['directus_token']!.text = provider.settings.directusKey;
    }
  }

  @override
  void dispose() {
    for(var ctrl in ctrlMap.entries){
      ctrl.value.dispose();
    }
    for(var fc in fcMap.entries){
      fc.value.dispose();
    }

    super.dispose();
  }

  /// Text input field icons
  String prefixIcon(String key){
    return switch(key){
      'igmg_api' || 'directus_api' => Mdi.api, _ => Mdi.shield_key_outline,
    };
  }
  /// Text input field labels
  Text? getLabel(String key){
    return switch(key){
      'igmg_api' || 'directus_api' => Text(
          key.split('_')[0].toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold)
      ), _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: ui.TextDirection.ltr,

      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {

          return RotatedBox(
            quarterTurns: provider.isLandscape? 0 :1,

            child: PopScope(
              canPop: false,
              /// on navigate POP
              onPopInvoked: (didPop){
                if(didPop){
                  return;
                }
                /// Update provider
                provider.updateEndpoints(
                    iApi: ctrlMap['igmg_api']!.text,
                    iKey: ctrlMap['igmg_token']!.text,
                    dApi: ctrlMap['directus_api']!.text,
                    dKey: ctrlMap['directus_token']!.text
                );
                Navigator.of(context).pop(true);
              },

              /// Body
              child: Scaffold(
                  backgroundColor: CupertinoColors.lightBackgroundGray,
                  appBar: AppBar(
                    title: Text('api_endpoints'.tr()),
                  ),

                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// Prayer times
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Iconify(FaSolid.pray),
                              SizedBox(
                                width: 300,
                                child: SwitchListTile(
                                  key: GlobalKey(),
                                  focusNode: _FC1,
                                  value: provider.settings.calculationMethod == CalculationMethod.turkey,
                                  inactiveThumbColor: Colors.deepPurple,
                                  title: Text('IGMG / Diyanet'),
                                  subtitle: Text('Gebetszeiten'),
                                  onChanged: (bool value) {
                                    provider.updatePayerTimesCalcMethod(
                                        method: value? CalculationMethod.turkey : CalculationMethod.other
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          /// IGMG Announcements switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Iconify(Carbon.carousel_horizontal),
                              SizedBox(
                                width: 300,
                                child: SwitchListTile(
                                  key: GlobalKey(),
                                  focusNode: _FC2,
                                  value: provider.settings.igmg,
                                  title: Text('Info-Board aus IGMG'),
                                  onChanged: (bool value) {
                                    provider.updateApiConnectionIGMG(igmgAnno: value);
                                  },
                                ),
                              ),
                            ],
                          ),

                          /// Directus Announcements switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Iconify(Carbon.carousel_horizontal),
                              SizedBox(
                                width: 300,
                                child: SwitchListTile(
                                  key: GlobalKey(),
                                  focusNode: _FC3,
                                  value: provider.settings.directus,
                                  title: Text('Info-Board aus Directus'),
                                  onChanged: (bool value) {
                                    provider.updateApiConnectionDirectus(directusAnno: value);
                                  },
                                ),
                              ),
                            ],
                          ),

                          ...fcMap.entries.map((e) => TextFormField(
                            onTapOutside: (event) => e.value.unfocus(),
                            focusNode: e.value,
                            controller: ctrlMap[e.key],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            obscureText: e.key.contains('token'),
                            onFieldSubmitted: (e.key == 'directus_token')?null: (val){
                              /// Focus next node
                              //focusNextNode(fcMap, fcMap[e.key]!);
                              //e.value.nextFocus();
                              //FocusTraversalGroup.of(context!).next(e.value);
                              if(e.key == 'igmg_api'){
                                fcMap['igmg_token']!.requestFocus();
                              }
                              if(e.key == 'directus_api'){
                                fcMap['directus_token']!.requestFocus();
                              }
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              label: getLabel(e.key),
                              contentPadding: const EdgeInsets.all(5.0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 14.0, right: 5),
                                child: Iconify(prefixIcon(e.key), color: Colors.black54, size: 12),
                              ),
                              //suffixIcon: suffixWidget(e.key),
                              isCollapsed: true,
                              labelStyle: const TextStyle(color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
                              focusColor: Colors.amber,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  borderSide: const BorderSide(
                                      color: Colors.amber
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  borderSide: const BorderSide(
                                      color: Colors.amber
                                  )
                              ),
                            ),
                            style: const TextStyle(color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
                          )).toList().joinWith(const SizedBox(height: 20)),
                        ],
                      ),
                    ),
                  )
              ),
            ),
          );
        }
      ),
    );
  }
}