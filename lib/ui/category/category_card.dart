/*
* Developer: Abubakar Abdullahi
* Date: 02/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme.dart';
import '../../data/model/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white70,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        //TODO: Go to tasks list page
        onTap: () {},


        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 35, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/${category.icon}.svg',
                  semanticsLabel: 'Menu',
                  color: Color(getColor(category.color)),
                  width: 30,
                  height: 30,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        category.title ?? '',
                        style: TwoDouTheme.globalTextTheme.headline2,
                      ),
                      Text(
                        getTaskCount(category.taskCount),
                        style: TwoDouTheme.globalTextTheme.bodyText2,
                      ),
                    ],
                  ),
                )
                // const SizedBox(
                //   height: 10.0,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
