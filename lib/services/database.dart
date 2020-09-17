import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  getUserByUsername(String username) async{

    return await Firestore.instance.collection("users")
        .where("name", isEqualTo: username ).getDocuments();

  }

  uploadUsersInfo(userMap){
    Firestore.instance.collection("users").add(userMap).catchError((e){
      print(e.toString());
    });
  }

  creatChatRoom(String chatRoomId, chatRoomMap)
  {
    Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(chatRoomMap)
        .catchError((e){
          print(e.toString());
    });
  }

}