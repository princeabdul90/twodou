/*
* Developer: Abubakar Abdullahi
* Date: 02/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twodou_app/feature/task/presentation/screen/task_screen.dart';

import '../../../../utility/theme.dart';
import '../../../task/presentation/provider/repository_implementation.dart';
import '../../domain/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<TaskRepositoryProvider>();

    return Container(
      padding: const EdgeInsets.only(top: 35, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white70,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TaskScreen(
                        category: category,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/${category.icon}.svg',
              semanticsLabel: '${category.title}',
              color: Color(getColor(category.color)),
              width: 30,
              height: 30,
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Text(
                  category.title ?? '',
                  style: TwoDouTheme.globalTextTheme.headline2,
                ),
                category.id! == 1
                    ? StreamBuilder(
                        stream: sp.findAllTasksCount(),
                        builder: (context, snapshot) {
                          final cat = snapshot.data;

                          return Text(
                            getTaskCount(cat),
                            style: TwoDouTheme.globalTextTheme.bodyText2,
                          );
                        },
                      )
                    : StreamBuilder(
                        stream: sp.findTasksCountByCategory(category.id!),
                        builder: (context, snapshot) {
                          final cat = snapshot.data;

                          return Text(
                            getTaskCount(cat),
                            style: TwoDouTheme.globalTextTheme.bodyText2,
                          );
                        },
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
