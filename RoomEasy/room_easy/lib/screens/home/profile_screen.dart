import 'package:flutter/material.dart';
import 'package:room_easy/screens/home/profile/change_preferences.dart';
import 'package:room_easy/screens/home/profile/edit_profile_screen.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:room_easy/services/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              physics:
                  NeverScrollableScrollPhysics(), //without this line the listview won't scroll lmfao
              shrinkWrap:
                  true, //https://stackoverflow.com/questions/54007073/what-does-the-shrinkwrap-property-do-in-flutter
              children: <Widget>[
                // User card
                BigUserCard(
                  cardColor: Color(0xffe24e3e),
                  userName: "Gertrude",
                  backgroundMotifColor: Color(0xffe24e3e),
                  userProfilePic: null, // work on this later
                  cardActionWidget: SettingsItem(
                    icons: Icons.edit,
                    iconStyle: IconStyle(
                      withBackground: true,
                      borderRadius: 5,
                      backgroundColor: Colors.yellow[600],
                    ),
                    title: "Modify",
                    subtitle: "Tap to change your data",
                    onTap: () {
                      print("OK");
                    },
                  ),
                ),
                SettingsGroup(
                  iconItemSize: 30,
                  items: [
                    SettingsItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      icons: CupertinoIcons.settings,
                      iconStyle: IconStyle(backgroundColor: Colors.grey),
                      title: 'Preferences',
                      subtitle: "Change your filters",
                    ),
                    SettingsItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChangePreferencesScreen(), //TODO: change name to EditPreferencesScreen()
                          ),
                        );
                      },
                      icons: CupertinoIcons.color_filter,
                      iconStyle: IconStyle(backgroundColor: Colors.grey),
                      title: 'Change Filters',
                      subtitle: "Change your filters",
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'About',
                      subtitle: "Learn more about Ziar'App",
                    ),
                  ],
                ),
                // You can add a settings title
                SettingsGroup(
                  settingsGroupTitle: "Account",
                  items: [
                    SettingsItem(
                      onTap: () async {
                        await AuthService().signOut();
                      },
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: CupertinoIcons.delete_solid,
                      title: "Delete account",
                      titleStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
