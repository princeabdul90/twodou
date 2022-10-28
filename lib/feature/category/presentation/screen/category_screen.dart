/*
* Developer: Abubakar Abdullahi
* Date: 04/08/2022
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/category_repository_provider.dart';
import 'category_card.dart';

import '../../domain/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
      final repository = Provider.of<CategoryRepositoryProvider>(context);
      return StreamBuilder(
        stream: repository.watchAllCategories(),
        builder: ( context, AsyncSnapshot<List<Category>> snapshot ){
          if (snapshot.hasData ){
            final categories = snapshot.data!;

            return GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
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
