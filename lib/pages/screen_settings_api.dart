import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tv_mosque/helper/extensions.dart';

import '../Logic/Provider/provider_settings.dart';

class ApiSettingsScreen extends StatefulWidget {
  const ApiSettingsScreen({super.key});

  @override
  State<ApiSettingsScreen> createState() => ApiSettingsScreenState();
}

class ApiSettingsScreenState extends State<ApiSettingsScreen> {
  final Map<String, TextEditingController> ctrlMap = {};
  final Map<String, FocusNode> fcMap = {};
  final Map<String, String> titlesMap = {
    'igmg_api':'IGMG API',
    'igmg_token':'IGMG Token',
    'directus_api':'Directus API',
    'directus_token':'Directus Token',
  };

  @override
  void initState() {
    super.initState();

    for(var entry in titlesMap.entries){
      ctrlMap.putIfAbsent(entry.key, () => TextEditingController());
      fcMap.putIfAbsent(entry.key, () => FocusNode());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

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

  clearValuetxt() {
    for(var fc in fcMap.entries){
      if(fc.value == FocusManager.instance.primaryFocus){
        ctrlMap[fc.key]?.clear();
      }
    }
  }

  setValuetxt(String data) {
    for(var fc in fcMap.entries){
      if(fc.value == FocusManager.instance.primaryFocus){
        ctrlMap[fc.key]?.text = (ctrlMap[fc.key]?.text ??'') + data;
      }
    }
  }

  setFocustxt() {
    for(var it = fcMap.entries.iterator; it.moveNext();){
      if(it.current.value == FocusManager.instance.primaryFocus){
        if(it.moveNext()){
          it.current.value.requestFocus();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,

      child: Consumer<SettingsProvider>(
        builder: (context, provider,child) {

          return RotatedBox(
            quarterTurns: provider.isLandscape? 0 :1,

            child: PopScope(
              /// on navigate POP
              onPopInvoked: (didPop){
                /// Update provider
                provider.updateEndpoints(
                    ctrlMap['igmg_api']!.text,
                    ctrlMap['igmg_token']!.text,
                    ctrlMap['directus_api']!.text,
                    ctrlMap['directus_token']!.text
                );
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...ctrlMap.entries.map((e) => TextFormField(
                            //autofocus: false,
                            onTapOutside: (event) => fcMap[e.key]?.unfocus(),
                            focusNode: fcMap[e.key],
                            controller: e.value,
                            keyboardType: TextInputType.text,
                            obscureText: e.key.contains('token'),
                            decoration: InputDecoration(
                              labelText: titlesMap[e.key],
                              suffixIcon: IconButton(
                                onPressed: () {
                                  e.value.clear();
                                },
                                icon: const Icon(Icons.close),
                                color: Colors.black38,
                              ),
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
                          )).toList().joinWith(
                            const SizedBox(height: 20),
                          ),
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