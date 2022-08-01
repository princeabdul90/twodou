/*
* Developer: Abubakar Abdullahi
* Date: 01/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          'assets/images/list.svg',
          semanticsLabel: 'Menu',
        ),
      ),

      body: Container(color: Colors.amber,),

      floatingActionButton:  FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}
