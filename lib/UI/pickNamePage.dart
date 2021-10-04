import 'package:chatrooms/UI/mainChatPage.dart';
import 'package:chatrooms/viewModel/pick_name_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PickNamePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  ViewModelBuilder<PickNameViewModel>.reactive(
          viewModelBuilder: () => PickNameViewModel(),

          builder: (context, model, child) =>
     Scaffold(
        appBar: AppBar(
    
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                 SizedBox(height: size.height/45,),
                Padding(
                 padding:  EdgeInsets.all(size.height/180),
        
                  child: Text("Pick a Avatar",style: TextStyle(fontSize: size.height/30,color: Theme.of(context).accentColor),),
                ),
               
                Padding(
                  padding:  EdgeInsets.all(size.height/180),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.height/35),),
                    height: size.height/2,
                    child: GridView.builder(gridDelegate:  new SliverGridDelegateWithFixedCrossAxisCount(
                                    
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 7,
                                      childAspectRatio: 1),
                                        itemCount: 8,
                                        itemBuilder: (context,index){
                                        return AvatarImage(index: index);
                                      }),
                   
                  ),
                ),
                 SizedBox(height: size.height/45,),
        
                  Padding(
                 padding:  EdgeInsets.all(size.height/180),
        
                  child: Text("Your NickName!",style: TextStyle(fontSize: size.height/30,color: Theme.of(context).accentColor),),
                ),
                Form(
                  key:  model.formKey,
                  child: Padding(
                    padding:  EdgeInsets.all(size.height/90),
                          
                    child: Container(
                      
                      child: TextFormField(
                        onSaved: (value)=>model.nickName=value??"",
                        validator: model.nameValidator,
                        maxLength: 30,
                        style: TextStyle(fontSize: size.height/30),
                        decoration: InputDecoration(
                          counterText: ""
                        ),
                      )),
                  ),
                ),
                    SizedBox(height: size.height/45,),
                    Padding(padding:EdgeInsets.all(size.height/90), 
              child: Container(
                height: size.height/15,
                width: size.width/1.3,
                child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
              shadowColor: Color(0xff577590),
              ),
                  onPressed: ()async{
                    bool status = await model.isValidForm(context);
                    if(status)
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>MainChatPage(nickName: model.nickName+"*"+"${model.selectedIndex}",)));


                    
                }, child: Center(child: Text("GO",style: TextStyle(fontSize: size.height/45,color:Colors.white)),)),
              ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


class AvatarImage extends ViewModelWidget<PickNameViewModel>{
  final int index;
  AvatarImage({required this.index});
  @override
  Widget build(BuildContext context, PickNameViewModel viewModel) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.all(size.height/90),
      child: InkWell(
        onTap: (){
          viewModel.selectedIndex = index;
          viewModel.notifyListeners();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color:viewModel.selectedIndex==index? Color(0xff577590):Colors.white, width: size.width/70),
              borderRadius: BorderRadius.circular(size.height/60),
            image: DecorationImage(image: AssetImage("assets/avatars/"+"$index"+".png"))
          ),
        ),
      ),
    );
  }

}