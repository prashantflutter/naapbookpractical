import "dart:developer";
import "dart:io";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:naapbook_practical/Constant/AppColors.dart";
import "package:naapbook_practical/Widgets/AppBarWidget.dart";
import "package:naapbook_practical/Widgets/AppButton.dart";
import "package:naapbook_practical/Widgets/AppDialog.dart";
import "package:naapbook_practical/Widgets/AppTextForm.dart";

import "../Constant/AppValidation.dart";
import "../Database/SqLiteDatabase.dart";
import "LoginPage.dart";

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  final  myKey = GlobalKey<FormState>();
  
  bool isPassword = true;
  bool isCPassword = true;

  ImagePicker picker = ImagePicker();
  String? image;

  void picImage()async{
  XFile?  file = await picker.pickImage(source: ImageSource.gallery);
  if(file == null){
    image = file!.path;
  }
  }

  List<Map<String,dynamic>> addNotebookDataList = [];

  Future<void>addData()async{
    await SQLiteDatabase.createData(
        fName: fNameController.text,
        lName: lNameController.text,
        email: emailController.text,
        mobile: mobileController.text,
        password: passwordController.text,
        designation: designationController.text);
    _refreshData();
  }

  void _refreshData() async {
    final data = await SQLiteDatabase.getAllData();
    setState(() {
      addNotebookDataList = data;
    });
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: MYAppBar(title: 'Registration')),
      body: Form(
        key: myKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // InkWell(
              //   child: CircleAvatar(
              //     radius: 15,
              //     child: Image.file(File(image!)),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: MyTextFrom(controller: fNameController, labelText: 'First Name',
                  onFieldSubmitted: (value){
                    fNameController.text = value.toString();
                  },
                  validator: (value){
                    return 'Please enter first name!';
                  },),
              ),
              MyTextFrom(controller: lNameController, labelText: 'Last Name',
                onFieldSubmitted: (value){
                  lNameController.text = value.toString();
                },
                validator: (value){
                  return 'Please enter last name!';
                },),
              MyTextFrom(controller: emailController, labelText: 'Email-id',
              onFieldSubmitted: (value){
                emailController.text = value.toString();
              },
                validator: (value){
                  return validateEmail(value.toString());
                }
              ),
              MyTextFrom(controller: mobileController, labelText: 'Mobile Number',
                keyboardType: TextInputType.number,
                maxLength: 10,
                onFieldSubmitted: (value){
                  mobileController.text = value.toString();
                },
                validator: (value){
                  return 'Please enter mobile number!';
                },),
              MyTextFrom(controller: designationController, labelText: 'Designation',
                onFieldSubmitted: (value){
                  designationController.text = value.toString();
                },
                validator: (value){
                  return 'Please enter designation!';
                },),
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
                  return 'Please enter password!';
                },),
              MyTextFrom(controller: cPasswordController, labelText: 'Confirm Password',
                obscureText: isCPassword,
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    isCPassword = !isCPassword;
                  });
                }, icon: Icon(isCPassword?Icons.visibility:Icons.visibility_off,color:green,)),
                onFieldSubmitted: (value){
                  cPasswordController.text = value.toString();
                },
                validator: (value){
                  return 'Please enter confirm password!';
                },),
              MyButton(onPressed: checkValidation, title: 'Submit'),
              MyTextButton(onTap: ()=> Get.to(LoginPage()), text: 'already account | login'),
          
          ],),
        ),
      ),
    );
  }



  void checkValidation(){
    if(myKey.currentState!.validate()){
      log("Data Processing...");
    }
    else if(emailController.text.isEmpty || fNameController.text.isEmpty || lNameController.text.isEmpty
        || mobileController.text.isEmpty || designationController.text.isEmpty
        || passwordController.text.isEmpty || cPasswordController.text.isEmpty){

    }else if(passwordController.text == cPasswordController.text){
      addData();
      Get.off(LoginPage());
      emailController.clear();
      fNameController.clear();
      lNameController.clear();
      passwordController.clear();
      cPasswordController.clear();
      designationController.clear();
      mobileController.clear();
      MyDialog(context: context, isError: false,title: 'Successfully Registration...');
    }
    else{
      MyDialog(context: context, title: 'Password are do not match');
    }
  }


}
