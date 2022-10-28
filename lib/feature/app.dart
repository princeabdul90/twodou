/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import 'package:flutter/material.dart';
import 'package:twodou_app/feature/task/presentation/screen/add_new_task.dart';

import '../utility/colors.dart';
import '../utility/theme.dart';
import 'category/presentation/screen/category_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        color: white,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: white,
              expandedHeight: 120,
              leading: const Icon(
                Icons.menu_rounded,
                size: 40,
                color: black,
              ),
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Lists',
                  style: TwoDouTheme.globalTextTheme.headline2,
                ),
                titlePadding: const EdgeInsets.only(left: 10.0, top: 10),

              ),
            ),

            const SliverToBoxAdapter(
                child: CategoryScreen()
            )

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     // Navigator.push(context, MaterialPageRoute(
      //     //     builder: (context) => const AddNewTask()
      //     // ));
      //   },
      // ),
    );
  }



}