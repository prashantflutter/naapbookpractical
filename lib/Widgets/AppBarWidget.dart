

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naapbook_practical/Constant/AppColors.dart';

Widget MYAppBar({required String title,bool leading = true}){
  return AppBar(
    backgroundColor: green,
    automaticallyImplyLeading: leading,
    centerTitle: true,
    title: Text(title,style: TextStyle(color: Colors.white,fontSize: 20),),
    leading: leading == false?null:IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)),
  );
}