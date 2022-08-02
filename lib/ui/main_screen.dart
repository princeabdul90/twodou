/*
* Developer: Abubakar Abdullahi
* Date: 01/08/2022
*/
import 'package:flutter/material.dart';
import 'package:twodou_app/ui/theme.dart';

import 'category/category_card.dart';
import 'colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        color: background,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: background,
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
            buildCategoryGrid(),
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

  Widget buildCategoryGrid() {
    return SliverToBoxAdapter(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemCount: 10,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return const CategoryCard();
        },
      ),
    );
  }
}
