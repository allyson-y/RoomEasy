class HelperFunctions
{
  String createChatRoomID(String uid_1, String uid_2)
  {
    if (uid_1.compareTo(uid_2) > 0)
    {
      return uid_1+"_"+uid_2;
    }
    else{
      return uid_2+"_"+uid_1;
    }
  }
}