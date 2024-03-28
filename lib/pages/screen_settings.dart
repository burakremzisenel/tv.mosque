import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tv_mosque/router.gr.dart';
import 'dart:ui' as ui;

import '../Logic/Provider/provider_settings.dart';
import 'package:iconify_flutter/icons/fa_solid.dart';
import 'package:badges/badges.dart' as badges;

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();


  }
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
                        trailing: badges.Badge(
                          showBadge: provider.settings.location == null,
                          position: badges.BadgePosition.topEnd(top: 2, end: 2),
                          child: IconButton(
                            focusColor: Colors.grey.shade300,
                            icon: const Icon(Icons.chevron_right_rounded),
                            onPressed: (){
                              context.pushRoute(const LanguageSettingsRoute());
                            },
                          ),
                        ),
                        title: Text('Land & Sprache'),
                        value: Text(context.locale.languageCode.toUpperCase()),
                        description: Text('language_settings_subtitle'.tr()),
                      ),

                      /// Announcement settings
                      SettingsTile.navigation(
                        leading: const Icon(Icons.chrome_reader_mode_outlined),
                        trailing: IconButton(
                          focusColor: Colors.grey.shade300,
                          icon: const Icon(Icons.chevron_right_rounded),
                          onPressed: (){
                            context.pushRoute(const SliderSettingsRoute());
                          },
                        ),
                        title: Text('announcements'.tr()),
                        description: Text('slider_duration'.tr()),
                      ),

                      /// API settings
                      SettingsTile.navigation(
                        leading: const Iconify(IconParkSolid.api, color: Colors.grey,),
                        trailing: badges.Badge(
                          showBadge: provider.settings.directusKey.isEmpty || provider.settings.directusApi.isEmpty,
                          position: badges.BadgePosition.topEnd(top: 2, end: 2),
                          child: IconButton(
                            focusColor: Colors.grey.shade300,
                            icon: const Icon(Icons.chevron_right_rounded),
                            onPressed: (){
                              context.pushRoute(const ApiSettingsRoute());
                            },
                          ),
                        ),
                        title: Text('api_endpoints'.tr()),
                        description: const Text('Directus, IGMG'),
                      ),

                      /// Show licenses
                      SettingsTile.navigation(
                        leading: const Iconify(Carbon.license_third_party, color: Colors.grey),
                        trailing: IconButton(
                          focusColor: Colors.grey.shade300,
                          icon: const Icon(Icons.chevron_right_rounded),
                          onPressed: (){
                            showLicensePage(
                              context: context,
                              applicationName: 'app_name'.tr(),
                            );
                          },
                        ),
                        title: const Text('Licence'),
                        description: const Text('License information'),
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