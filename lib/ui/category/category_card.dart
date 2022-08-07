/*
* Developer: Abubakar Abdullahi
* Date: 02/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twodou_app/data/repository.dart';
import 'package:twodou_app/ui/task/task_page.dart';
import '../theme.dart';
import '../../data/model/model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(top: 35, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white70,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),

        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => TaskPage(category: category,)
          ));
        },

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
          ],
        ),
        ),
    );
  }

}
