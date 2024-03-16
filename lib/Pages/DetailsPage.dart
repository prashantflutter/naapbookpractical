import 'package:flutter/material.dart';

import '../Constant/AppColors.dart';
import '../Widgets/AppBarWidget.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String mobile;

  const DetailsPage({super.key, required this.name, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: MYAppBar(title: '$name Details',)),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: green.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(3, 3)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle_outlined,color: green,size: 50,),
            ),
            Text('Name : $name',style: TextStyle(color: green,fontSize: 22),),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text('Mobile : $mobile',style: TextStyle(color: midGreen,fontSize: 18),),
            ),
          ],
        ),
      ),

    );
  }
}
