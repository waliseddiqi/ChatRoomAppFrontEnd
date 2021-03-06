import 'package:chatrooms/locator.dart';
import 'package:chatrooms/models/message.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
class SocketConnectViewModel extends BaseViewModel{
List<Message> messages = [];
TextEditingController sendField = new TextEditingController();

final String nickName;
SocketConnectViewModel({required this.nickName});
  Socket socket = io('https://chatapprooms.herokuapp.com/', 
    OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
       // optional
      .build()
  );





Future connectToSocket()async{
  print("connecting");

socket.connect();
socket.onConnect((_) {

  socket.emit('connected', nickName.split("*")[0]);
});
socket.on("UserJoined", (data){
  print("A user has Joined named"+data);
});
onMessageRecieve();
onUserJoined();
// socket.on('event', (data) => print(data));
// socket.onDisconnect((_) => print('disconnect'));
// socket.on('fromServer', (_) => print(_));
}


Future onUserJoined()async{
socket.on("UserJoined", (data){

SnackbarService snackbar = locator<SnackbarService>();
snackbar.showSnackbar(message: "$data"+"has joined!",title: "User Joined!",);
});
}

Future onMessageRecieve()async{
  print("message recieved");
socket.on("OnRecieveMessage", (data){

  Message newMessage = new Message(body: "${data['body']}", sender: "${data['sender']}", avatarID: "${data['avatarID']}",isSelf: false);
  messages.add(newMessage);
  notifyListeners();
});

}


Future sendMessage(String body)async{
  
  socket.emit("OnSendMessage",{"body":body,"sender":nickName.split("*")[0],"avatarID":nickName.split("*").last});
}


void addfakeMEssage(String body){
  messages.add(new Message(body: body, sender: "You", avatarID: nickName.split("*").last,isSelf: true,));
  notifyListeners();
}

}