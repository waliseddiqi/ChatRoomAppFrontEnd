import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PickNameViewModel extends BaseViewModel{


int selectedIndex = 0;

String nickName = "";



  GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? nameValidator(String? value){
    if (value == null || value.isEmpty) return 'Type a nickName.';
    return null;
  }




    Future<bool> isValidForm(BuildContext context) async {
    

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
         FocusScope.of(context).unfocus();
        return true;
        ///everything is cool 
   
      
    }else{
    return false;
    }
  
  }
}