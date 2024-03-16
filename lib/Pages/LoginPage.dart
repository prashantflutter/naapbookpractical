import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naapbook_practical/Pages/DashboardPage.dart';
import 'package:naapbook_practical/Pages/RegistrationPage.dart';

import '../Constant/AppColors.dart';
import '../Constant/AppValidation.dart';
import '../Database/SqLiteDatabase.dart';
import '../Widgets/AppBarWidget.dart';
import '../Widgets/AppButton.dart';
import '../Widgets/AppDialog.dart';
import '../Widgets/AppTextForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final  myKey = GlobalKey<FormState>();
  List<Map<String,dynamic>> userData = [];
  bool isPassword = true;
  void _refreshData() async {
    final data = await SQLiteDatabase.getAllData();
    setState(() {
      userData = data;
    });
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  void checkValidation(){
    if(myKey.currentState!.validate()){
      log("Data Processing...");
    }
    if(emailController.text.isNotEmpty || passwordController.text.isNotEmpty){
      for(int i=0;i<userData.length;i++){
      var  email = userData[i]['email'];
      var  password = userData[i]['password'];
        log('Email 2:${userData[i]['email']}');
        log('Password 2:${userData[i]['password']}');
        if(emailController.text == email || passwordController.text == password){
          Get.offAll(DashboardPage());
          MyDialog(context: context, title: 'Successfully login...',isError: false);
        }
      }
    }
    else{
      MyDialog(context: context, title: 'Please enter validate email & password!');
    }
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: MYAppBar(title: 'Login',leading: false)),
      body: Form(
        key: myKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: MyTextFrom(controller: emailController, labelText: 'Email-id',
                    onFieldSubmitted: (value){
                      emailController.text = value.toString();
                    },
                    validator: (value){
                      if(value.toString().isEmpty){
                        return 'Please enter email!';
                      }
                      return null;
                    }
                ),
              ),
              MyTextFrom(controller: passwordController, labelText: 'Password',
                obscureText: isPassword,
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    isPassword = !isPassword;
                  });
                }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color:green,)),
                onFieldSubmitted: (value){
                  passwordController.text = value.toString();
                },
                validator: (value){
                if(value.toString().isEmpty){
                  return 'Please enter password!';
                }
                  return null;
                },),
              MyButton(onPressed: checkValidation, title: 'Login'),
              MyTextButton(onTap: ()=> Get.to(RegistrationPage()), text: 'you do n\'t have account | registration'),
            ],),
        ),
      ),
    );
  }




}
