import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/config/helper/scheduling_provider.dart';
import 'package:restaurant/config/widget/dialog/custom_dialog.dart';
import 'package:restaurant/config/widget/platform/platform_widget.dart';

class SettingScreen extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingScreen({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SchedulingProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Scheduling News'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledNews(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:restaurant/data/local/favorite_storage.dart';
// import 'package:restaurant/screens/components/text_title.dart';
//
// class SettingScreen extends StatefulWidget {
//   const SettingScreen({super.key});
//
//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends State<SettingScreen> {
//   bool isActive = false;
//
//   @override
//   void initState() {
//     initialData();
//     super.initState();
//   }
//
//   initialData() async {
//     bool isNotification =
//         await FavoriteStorage.getStatusNotification() ?? false;
//     setState(() {
//       isActive = isNotification;
//     });
//     debugPrint("THIS ISACTIVE: $isActive");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).padding.top,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const TextTitle(
//               title: "Setting",
//               subtitle: Text(
//                 "Set Your Setting Application",
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Restaurant Notification',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Text(
//                           'Enable Notification',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Switch.adaptive(
//                     value: isActive,
//                     onChanged: (value) async {
//                       setState(() {
//                         isActive = !isActive;
//                       });
//                       await FavoriteStorage.setJSON(
//                         {"notification": value},
//                       );
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
