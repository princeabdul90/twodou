/*
* Developer: Abubakar Abdullahi
* Date: 07/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../utility/custom_widgets/circle_icon.dart';
import '../../../../utility/custom_widgets/task_tile.dart';
import '../../../category/domain/category.dart';
import 'package:twodou_app/feature/task/domain/task.dart';
import 'package:twodou_app/feature/task/presentation/provider/repository_implementation.dart';
import 'add_new_task.dart';

import '../../../../utility/colors.dart';

class TaskScreen extends StatefulWidget {
  final Category category;
  const TaskScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  void deleteRecipe(Task task) {
    final sp = context.read<TaskRepositoryProvider>();

    if (task.id != null) {
      sp.deleteTask(task);

      setState(() {});
    } else {
      print('Task id is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<TaskRepositoryProvider>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(getColor(widget.category.color)),
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/chevron-left.svg',
                        color: Colors.white,
                        width: 20,
                      )),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/three-dots-vertical.svg',
                        color: white,
                        width: 20,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleIcon(
                    icon: SvgPicture.asset(
                      'assets/images/${widget.category.icon}.svg',
                      color: Color(getColor(widget.category.color)),
                      width: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.category.title ?? 'All',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  widget.category.id! == 1
                      ? StreamBuilder(
                          stream: sp.findAllTasksCount(),
                          builder: (context, snapshot) {
                            final cat = snapshot.data;

                            return Text(
                              getTaskCount(cat),
                              style: const TextStyle(color: Colors.white),
                            );
                          },
                        )
                      : StreamBuilder(
                          stream:
                              sp.findTasksCountByCategory(widget.category.id!),
                          builder: (context, snapshot) {
                            final cat = snapshot.data;

                            return Text(
                              getTaskCount(cat),
                              style: const TextStyle(color: Colors.white),
                            );
                          },
                        ),
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
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildTasks(context),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewTask(
                        category: widget.category,
                      )));
        },
      ),
    );
  }

  Widget _buildTasks(BuildContext context) {
    final sp = context.watch<TaskRepositoryProvider>();

    //TODO: Change the category.id == 1 to something dynamic
    if (widget.category.id == 1) {
      return StreamBuilder(
          stream: sp.watchAllTasks(),
          builder: (context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.hasData ){

              final tasks = snapshot.data!;
              return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {

                    final task = tasks[index];

                    return Slidable(
                      child: TaskTile(
                        task: task,
                      ),
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            label: 'Delete',
                            icon: Icons.delete,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            onPressed: (context) => deleteRecipe(task),
                          )
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            label: 'Delete',
                            icon: Icons.delete,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            onPressed: (context) => deleteRecipe(task),
                          )
                        ],
                      ),
                    );
                  });
            }else {
              return const Text('No Data');
            }


            // if (snapshot.connectionState == ConnectionState.active) {
            //   final tasks = snapshot.data ?? [];
            //
            //   return ListView.builder(
            //       itemCount: tasks.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         final task = tasks[index];
            //
            //         return Slidable(
            //           child: TaskTile(
            //             task: task,
            //           ),
            //           startActionPane: ActionPane(
            //             motion: const StretchMotion(),
            //             children: [
            //               SlidableAction(
            //                 label: 'Delete',
            //                 icon: Icons.delete,
            //                 foregroundColor: Colors.white,
            //                 backgroundColor: Colors.red,
            //                 onPressed: (context) => deleteRecipe(task),
            //               )
            //             ],
            //           ),
            //           endActionPane: ActionPane(
            //             motion: const ScrollMotion(),
            //             children: [
            //               SlidableAction(
            //                 label: 'Delete',
            //                 icon: Icons.delete,
            //                 foregroundColor: Colors.white,
            //                 backgroundColor: Colors.red,
            //                 onPressed: (context) => deleteRecipe(task),
            //               )
            //             ],
            //           ),
            //         );
            //       });
            // } else {
            //   return const Text('No Data');
            // }
          });
    } else {
      return StreamBuilder<List<Task>>(
          stream: sp.findAllTasksByCategory(widget.category.id!),
          builder: (context, AsyncSnapshot snapshot) {

              if (snapshot.hasData ){
                final tasks = snapshot.data!;
                return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];
                      return Slidable(
                        child: TaskTile(
                          task: task,
                        ),
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              label: 'Delete',
                              icon: Icons.delete,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              onPressed: (context) => deleteRecipe(task),
                            )
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              label: 'Delete',
                              icon: Icons.delete,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              onPressed: (context) => deleteRecipe(task),
                            )
                          ],
                        ),
                      );
                    });

              }else {
                return const Text('No Data');
              }


            // if(snapshot.connectionState == ConnectionState.active) {
            //   final tasks = snapshot.data ?? [];
            //
            //   return ListView.builder(
            //       itemCount: tasks.length,
            //       itemBuilder: (BuildContext context, int index){
            //         final task = tasks[index];
            //         return TaskTile(task: task,);
            //       }
            //   );
            // }else{
            //   return const Text('No Data');
            // }
          });
    }
  }
}
