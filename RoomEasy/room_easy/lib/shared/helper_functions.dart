class HelperFunctions {
  String createChatRoomID(String uid_1, String uid_2) {
    if (uid_1.compareTo(uid_2) > 0) {
      return uid_1 + "_" + uid_2;
    } else {
      return uid_2 + "_" + uid_1;
    }
  }

  String sleepTimeFormat(int sleepTime) {
    String x = "";
    if (sleepTime >= 12) {
      if (sleepTime == 12) {
        x += sleepTime.toString();
      } else {
        x += (sleepTime % 12).toString();
      }
      x += " AM";
    } else {
      x += sleepTime.toString() + "PM";
    }
    return x;
  }
}
