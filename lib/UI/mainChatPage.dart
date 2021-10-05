import 'package:chatrooms/UI/components/messagebody.dart';
import 'package:chatrooms/models/message.dart';
import 'package:chatrooms/viewModel/socket_connect_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainChatPage extends StatelessWidget{
  final String nickName;
  MainChatPage({required this.nickName});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

   return  ViewModelBuilder<SocketConnectViewModel>.reactive(
          viewModelBuilder: () => SocketConnectViewModel(nickName: nickName),
         onModelReady: (SocketConnectViewModel model){
           model.connectToSocket();
           print("object");
         },
          builder: (context, model, child) => SafeArea(child: Scaffold(
            

            appBar: AppBar(
              
              title: Text("Main room",style: TextStyle(fontSize: size.height/45,color: Colors.white),),
            ),

            body: SingleChildScrollView(
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height:size.height/1.1,
                      width: size.width,
                     
                      child: Column(
                        children: [
                          MessagesList(),
                        ],
                      ),
                    ),
                    MessageTextField()
            
                  ],
                ),
              ),
            ),


          )));
  }

}



class MessageTextField extends ViewModelWidget<SocketConnectViewModel>{
  @override
  Widget build(BuildContext context, SocketConnectViewModel viewModel) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.all(size.height/360),
      child: Container(
          margin: EdgeInsets.only(bottom: size.height/75),
         height: size.height/9,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.height/45),
          color: Color(0xff577590)
          
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(child: Padding(
              padding:  EdgeInsets.all(size.height/180),
              child: TextField(
                maxLines: null,
                
                expands: true,
                keyboardType: TextInputType.multiline,
                controller: viewModel.sendField,
                style: TextStyle(fontSize: size.height/45,color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: Container(
                          height: size.aspectRatio*100,
                      width: size.aspectRatio*100,
                     
                      decoration: BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.circular(size.height/20)),
                    child: ElevatedButton(
                      
                      style:  ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size.height/20))
                      ),
                      onPressed: (){
                        print(viewModel.nickName.split("*").last);
                        //viewModel.addfakeMEssage(viewModel.sendField.text.toString());
                        viewModel.sendMessage(viewModel.sendField.text.toString());
                        viewModel.addfakeMEssage(viewModel.sendField.text.toString());
                        viewModel.sendField.clear();
                      },
                      child: Center(child: Icon(Icons.send,color: Colors.white,))
                    ),
                  ),
                  border: InputBorder.none
                ),
              ),
            ),),
          ),
        ],
      ),
    ));
  }







}

class MessagesList extends ViewModelWidget<SocketConnectViewModel>{
  @override
  Widget build(BuildContext context, SocketConnectViewModel viewModel) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:EdgeInsets.all(size.height/180),
      child: Center(
        child: Container(
          height: size.height/1.32,
         
         child: ListView.builder(
           itemCount: viewModel.messages.length,
          // itemExtent: size.height/10,
           itemBuilder: (context,index){
             Message message = viewModel.messages[index];
           return MessageBody(avatarID: message.avatarID,body: message.body,sender: message.sender,isSelf: message.isSelf,);
         }),
        ),
      ),
    );
  }



}
