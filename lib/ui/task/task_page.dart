/*
* Developer: Abubakar Abdullahi
* Date: 07/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twodou_app/ui/task/task_tile.dart';
import 'package:twodou_app/ui/task/circle_icon.dart';


import '../colors.dart';
import '../../data/model/model.dart';

class TaskPage extends StatelessWidget {
  final Category category;
  const TaskPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.indigoAccent.shade400,
              Colors.indigoAccent.shade200,
              Colors.indigoAccent.shade100,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            // Menu buttons
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/images/chevron-left.svg', color: Colors.white, width: 20,)),
                  GestureDetector(
                      onTap: (){},
                      child: SvgPicture.asset('assets/images/three-dots-vertical.svg', color: white, width: 20,)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   CircleIcon(icon: SvgPicture.asset('assets/images/${category.icon}.svg', color: Color(getColor(category.color)), width: 20,),),
                   const SizedBox(height: 10),
                    Text(category.title ?? 'All', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold), ),
                   const Text('23 Tasks',  style: TextStyle(color: Colors.white),),
                 ],
              ),
            ),
            // White container starts here
            const SizedBox(height: 25),
            Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                  ),

                  child: Padding(
                   padding: const EdgeInsets.all(20.0),
                    child: ListView(
                        children: const [
                          TaskTile(),
                          TaskTile(),
                          TaskTile(),
                          TaskTile(),
                          TaskTile(),
                          TaskTile(),
                          TaskTile(),
                          TaskTile(),
                          TaskTile(),
                        ],
                    ),
                  ),
                ),
            )
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        //TODO: Go to add Task Page
        onPressed: () {},
      ),
    );
  }
}
