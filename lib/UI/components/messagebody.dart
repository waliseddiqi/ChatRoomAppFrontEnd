import 'package:flutter/material.dart';

class MessageBody extends StatefulWidget{
  final String sender;
  final String body;
  final String avatarID;
  final bool isSelf;
  const MessageBody({Key? key,required this.sender,required this.body,required this.avatarID,required this.isSelf}) : super(key: key);

  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> with SingleTickerProviderStateMixin{


  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
   animationController = new AnimationController(duration: Duration(milliseconds:100),vsync: this);
   animation = Tween<double>(begin: 0.8,end: 1).animate(animationController);
   animationController.forward();
    super.initState();
  }
  @override
  void dispose() {
   animationController.dispose();
   
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
       !widget.isSelf? Column(
            children: [
              Container(
                width: size.aspectRatio*80,
                height: size.aspectRatio*80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.height/20),
                image: DecorationImage(image: AssetImage("assets/avatars/"+"${widget.avatarID}"+".png"))
              ),),
              Container(child: Text(widget.sender,style: TextStyle(fontSize: size.height/80,color: Colors.red),),),
            ],
          ):SizedBox(),
                 
        Expanded(
          child: Align(
            alignment: widget.isSelf?Alignment.centerRight:Alignment.centerLeft,
            child: ScaleTransition(
              scale: animation,
              child: Padding(
                padding:  EdgeInsets.all(size.height/90),
                child: Container(
                    constraints: BoxConstraints(minWidth: size.width/5, maxWidth: size.width*0.7,minHeight: size.height/17),
                
                  width: size.width/1.5,
                  decoration: BoxDecoration(
                       color: Color(0xff577590),
                    borderRadius: BorderRadius.circular(size.height/65)
                    
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(size.height/150),
                      child: Text(widget.body,style: TextStyle(fontSize: size.height/50,color: Colors.white),),
                    ),
                    
                ),
              ),
            ),
          ),
        ),
            widget.isSelf? Column(
            children: [
              Container(
                width: size.aspectRatio*80,
                height: size.aspectRatio*80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.height/20),
                image: DecorationImage(image: AssetImage("assets/avatars/"+"${widget.avatarID}"+".png"))
              ),),
              Container(child: Text(widget.sender,style: TextStyle(fontSize: size.height/80,color: Colors.red),),),
            ],
          ):SizedBox(),
      ],
    );
  }
}