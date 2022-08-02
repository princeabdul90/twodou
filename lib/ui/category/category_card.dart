/*
* Developer: Abubakar Abdullahi
* Date: 02/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme.dart';
import '../colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.fromLTRB(20, 25, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/file-text.svg',
                  semanticsLabel: 'Menu',
                  color: blue,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All',
                        style: TwoDouTheme.globalTextTheme.headline2,
                      ),
                      Text(
                        '21 Tasks',
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
