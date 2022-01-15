/**
 * Represents a single text message
 */
class RmEasyChat
{
    final String chatRoomID_;
    final String sentByUID_;
    final String text_;
    final int ms_since_epoch_;
    final String time_sent_;

    RmEasyChat({this.chatRoomID_,this.sentByUID_, this.text_, this.time_sent_, this.ms_since_epoch_});
}