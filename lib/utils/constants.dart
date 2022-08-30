import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


String userId = "";
String userName = "";
String memoryName = "";
var userImage = ValueNotifier<String>("");
var notificationCount = ValueNotifier<int>(0);
String userEmail = "";
String globalNotificationToken = "";
bool isSocailUser = false;
String changePassword = "Change Password";

bool fromShare = false;
 // MemoriesModel? globalShareMemoryModel ;
//collections
String memoriesCollection = "memories";
String userCollection = "users";
String shareLinkCollection = "share_links";
String commentsCollection = "comments";
String notificationsCollection = "notifications";

// App bar Titles
String memoriesTitle = "Memories";
String settingsTitle = "Settings";
String notifications = "Notifications";


bool checkValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}


