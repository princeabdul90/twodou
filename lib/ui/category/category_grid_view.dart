/*
* Developer: Abubakar Abdullahi
* Date: 04/08/2022
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_card.dart';
import '../../data/repository.dart';
import '../../data/model/model.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
      final repository = Provider.of<Repository>(context);
      return FutureBuilder(
        future: repository.findAllCategories(),
        builder: ( context, AsyncSnapshot<List<Category>> snapshot ){
          if (snapshot.hasData ){
            final categories = snapshot.data!;

            return GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              primary: false,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                final category = categories[index];
                return  CategoryCard(category: category);
              },
            );

          }else {
            return Container();
          }
        },
      );





  }
}
