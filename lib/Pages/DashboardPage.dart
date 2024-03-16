import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naapbook_practical/Constant/AppColors.dart';
import 'package:naapbook_practical/Pages/DetailsPage.dart';
import 'package:naapbook_practical/Widgets/AppButton.dart';
import 'package:naapbook_practical/Widgets/AppDialog.dart';
import 'package:naapbook_practical/Widgets/AppTextForm.dart';

import '../Database/SqLiteDatabase.dart';
import '../Widgets/AppBarWidget.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  TextEditingController addContactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  List<Map<String,dynamic>> contactData = [];

  void _refreshContactData() async {
    final data = await SQLiteDatabase.getAllContactData();
    setState(() {
      contactData = data;
    });
  }

  @override
  void initState() {
    _refreshContactData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: MYAppBar(title: 'Dashboard',leading: false)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contactData.length,
                itemBuilder: (context,index){
                log('Data: ${contactData.length}');
                var name = contactData[index]['name'];
                var mobile = contactData[index]['mobile'];
              return contactData.isEmpty?
                  Card(child: Text('Empty Data...',style: TextStyle(color: green,fontSize: 16),),):
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    child: InkWell(
                      onTap: (){
                        Get.to(DetailsPage(name: contactData[index]['name'], mobile: contactData[index]['mobile'],));
                      },
                      child: Card(
                        child: ListTile(
                      leading: Icon(Icons.account_circle_outlined,color: green,size: 30,),
                      title: Text('Name : $name',style: TextStyle(color: green,fontSize: 16,fontWeight: FontWeight.w400),),
                      subtitle: Text('Mobile : $mobile',style: TextStyle(color: midGreen,fontSize: 13,fontWeight: FontWeight.w300),),
                      trailing: Icon(Icons.call,color: green,size: 25,),
                                      ),
                                    ),
                    ),
                  );
            }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: contactData.length,
                itemBuilder: (context,index){
                  log('Data: ${contactData.length}');
                  var name = contactData[index]['name'];
                  var mobile = contactData[index]['mobile'];
                  return contactData.isEmpty?
                  Card(child: Text('Empty Data...',style: TextStyle(color: green,fontSize: 16),),):
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 2,
                          )
                        ]
                      ),
                      child: InkWell(
                        onTap: (){
                          Get.to(DetailsPage(name: contactData[index]['name'], mobile: contactData[index]['mobile'],));
                        },
                        child: ListTile(
                          leading: Icon(Icons.account_circle,color: green,size: 40,),
                          title: Text('Name : $name',style: TextStyle(color: green,fontSize: 16,fontWeight: FontWeight.w600),),
                          subtitle: Text('Mobile : $mobile',style: TextStyle(color: midGreen,fontSize: 13,fontWeight: FontWeight.w500),),
                          trailing: CircleAvatar(
                            backgroundColor: green,
                              child: Icon(Icons.call,color: lightGreen,size: 25,)),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: contactData.length,
                itemBuilder: (context,index){
                  log('Data: ${contactData.length}');
                  var name = contactData[index]['name'];
                  var mobile = contactData[index]['mobile'];
                  return contactData.isEmpty?
                  Card(child: Text('Empty Data...',style: TextStyle(color: green,fontSize: 16),),):
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: midGreen,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 2,
                            offset: Offset(5, 5)
                          ),
                        ]
                      ),
                      child: InkWell(
                        onTap: (){
                          Get.to(DetailsPage(name: contactData[index]['name'], mobile: contactData[index]['mobile'],));
                        },
                        child: ListTile(
                          leading: Icon(Icons.contact_phone,color: Colors.white,size: 40,),
                          title: Text('Name : $name',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                          subtitle: Text('Mobile : $mobile',style: TextStyle(color: Colors.white,fontSize: 13),),
                          trailing: Icon(Icons.call,color: Colors.white,size: 25,),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        onPressed: addContact,
        child: Icon(Icons.add,color: Colors.white,),),
    );
  }


  void addContact(){
    showDialog(context: context, builder: (context){
      return SimpleDialog(
        children: [
          Center(child: Text('Add Contact',style: TextStyle(color: green,fontSize: 20),)),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: MyTextFrom(controller: nameController, labelText: 'Name',maxLength: 10),
          ),
          MyTextFrom(controller: addContactController, labelText: 'Mobile Number',maxLength: 10,keyboardType: TextInputType.number),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: MyButton(onPressed: (){
              if(nameController.text.isEmpty || addContactController.text.isEmpty){
                MyDialog(context: context, title: 'Please fill name & mobile number!');
              }else{
                SQLiteDatabase.addContacts(name: nameController.text, mobile:addContactController.text).whenComplete((){
                  MyDialog(context: context, title: 'Contact add successfully...',isError:false);
                  nameController.clear();
                  addContactController.clear();
                  _refreshContactData();
                  Get.back();
                });
                // MyDialog(context: context, title: 'Contact add successfully...',isError:false);
              }
            }, title: 'Add Now',width: 80),
          )
        ],
      );
    });
  }
}
