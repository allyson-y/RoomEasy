import 'package:flutter/material.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/screens/home/profile/change_preferences.dart';
import 'package:room_easy/screens/home/profile/edit_profile_screen.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:room_easy/services/auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    RmEasyUser currUser = Provider.of<RmEasyUser>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 229, 229, 234),
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
                SimpleUserCard(
                  userName: currUser.name_,
                  userProfilePic:
                      NetworkImage(currUser.imageURL_), // work on this later
                  imageRadius: 20,
                ),
                SettingsItem(
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
                Center(
                  child: Text(currUser.selfDescription_ ?? "HJe"),
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
                      subtitle: "Learn More about RoomEasy",
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
