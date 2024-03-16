import 'package:flutter/material.dart';
import 'package:naapbook_practical/Constant/AppColors.dart';

Widget MyButton({
  required void Function()? onPressed,
  required String title,
  double width = 200,
  double height = 55,
}){
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.only(top: 15),
    child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: green,
        ),
        child: Text(title,style: TextStyle(color: Colors.white,fontSize: 14,),)),
  );
}


Widget MyTextButton({required void Function()? onTap,required String text}){
  return Padding(
    padding: const EdgeInsets.only(top:5),
    child: InkWell(
      onTap: onTap,
      child: Text(text,style: TextStyle(color: midGreen),),
    ),
  );
}