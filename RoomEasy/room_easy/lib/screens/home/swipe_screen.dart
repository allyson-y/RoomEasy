import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/shared/helper_functions.dart';

/**
 * Kevin Kim kekim@hmc.edu 2-22-2022
 * reference :https://api.flutter.dev/flutter/widgets/PageView-class.html
 */
class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

/**
 * NOTE: IMPLEMENT SOME SORT OF LOADING SCREEN WHILE USERLIST IS NULL OR SMTHNG
 */
class _SwipeScreenState extends State<SwipeScreen> {
  @override
  Widget build(BuildContext context) {
    List<RmEasyUser> userList = Provider.of<List<RmEasyUser>>(context);
    RmEasyUser currUser = Provider.of<RmEasyUser>(context);
    final PageController controller = PageController();

    //PageView allows for the swiping thing to happen
    //NOTE: We can choose between PageView, PageView.custom, and PageView.builder. Which is better suited for our purposes?

    return (userList == null)
        ? SpinKitChasingDots(color: Color(0xffe24e3e), size: 50)
        : PageView(
            controller: controller,
            //NOTE: do we want to pass in a provider in this build function and for each PageView pass in a roomeasy user so we can sort of load in all the roomeasy
            //users before this runs. idk. Pros would be that we woudn't have to do build for each pageview that loads to load in our own user.
            children: HelperFunctions().mapRmEasyUserToWidget(
                userList), //NOTE: probably just map here, instead of calling a separate HelperFunctions() for readibility
          );
  }
}
