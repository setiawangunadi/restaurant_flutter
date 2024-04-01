import 'package:flutter/material.dart';
import 'package:restaurant/data/local/favorite_storage.dart';
import 'package:restaurant/screens/components/text_title.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isActive = false;

  @override
  void initState() {
    initialData();
    super.initState();
  }

  initialData() async {
    bool isNotification =
        await FavoriteStorage.getStatusNotification() ?? false;
    setState(() {
      isActive = isNotification;
    });
    debugPrint("THIS ISACTIVE: $isActive");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextTitle(
              title: "Setting",
              subtitle: Text(
                "Set Your Setting Application",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Restaurant Notification',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Enable Notification',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isActive,
                    onChanged: (value) async {
                      setState(() {
                        isActive = !isActive;
                      });
                      await FavoriteStorage.setJSON(
                        {"notification": value},
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
