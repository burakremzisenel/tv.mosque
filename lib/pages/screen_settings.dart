import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tv_mosque/pages/screen_settings_api.dart';
import 'dart:ui' as ui;
import 'package:tv_mosque/pages/screen_settings_language.dart';
import 'package:tv_mosque/pages/screen_settings_slider.dart';

import '../Logic/Provider/provider_settings.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,

      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          IconData layoutIcon;
          String layoutTitle;
          if(provider.isLandscape){
            layoutIcon = CupertinoIcons.device_phone_landscape;
            layoutTitle = 'layout_horizontal'.tr();
          } else {
            layoutIcon = CupertinoIcons.device_phone_portrait;
            layoutTitle = 'vertical_horizontal'.tr();
          }

          return RotatedBox(
            quarterTurns: provider.isLandscape? 0 :1,
            child: Scaffold(

              appBar: AppBar(
                title: Text('main_settings'.tr()),
              ),

              body: SettingsList(
                platform: DevicePlatform.iOS,
                sections: [
                  SettingsSection(
                    //title: Text('main_settings'.tr()),

                    tiles: <SettingsTile>[

                      /// Layout toggle switch
                      SettingsTile.switchTile(
                        leading: Icon(layoutIcon),
                        initialValue: provider.isLandscape,
                        onToggle: (val){
                          provider.toggleOrientation();
                        },
                        title: Text(layoutTitle),
                        description: const Text('Landscape, portrait'),
                      ),

                      /// Language settings
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: Text('language'.tr()),
                        value: Text(context.locale.languageCode.toUpperCase()),
                        description: Text('language_settings_subtitle'.tr()),
                        onPressed: (context){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LanguageSettingsScreen()),
                          );
                        },
                      ),

                      /// Announcement settings
                      SettingsTile.navigation(
                        leading: const Icon(Icons.chrome_reader_mode_outlined),
                        title: Text('announcements'.tr()),
                        description: Text('slider_duration'.tr()),
                        onPressed: (context){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SliderSettingsScreen()),
                          );
                        },
                      ),

                      /// API settings
                      SettingsTile.navigation(
                        leading: const Iconify(IconParkSolid.api, color: Colors.grey,),
                        title: Text('api_endpoints'.tr()),
                        description: const Text('Directus, IGMG'),
                        onPressed: (context){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ApiSettingsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}