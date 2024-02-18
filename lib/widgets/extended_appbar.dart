import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Logic/Provider/provider_clock.dart';
import '../pages/screen_settings.dart';

class ApplicationToolbar extends StatelessWidget implements PreferredSizeWidget{
  const ApplicationToolbar({super.key, required this.icon, required this.title});

  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Selector<ClockViewModel, bool>(
      selector: (_, provider) => provider.appbarVisible,
      builder: (context, visibility, child) {
        return Visibility(
          visible: visibility,
          child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 15),
                Text(title)
              ],
            ),
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context)=>[
                  PopupMenuItem(
                    value:1,
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                    child: const Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.settings),
                          ),
                          Text(
                            'Ayarlar',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}