/*
* Developer: Abubakar Abdullahi
* Date: 07/08/2022
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:twodou_app/feature/category/domain/category.dart';
import 'package:twodou_app/feature/task/domain/task.dart';

import '../../../../utility/theme.dart';
import '../../../../utility/colors.dart';
import '../provider/repository_implementation.dart';

class AddNewTask extends StatefulWidget {
  final Category category;
  const AddNewTask({Key? key, required this.category }) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  final _contentController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime createdAt = DateTime.now();

  String content = '';
  String note = '';


  void printLatestValue() {
    content = _contentController.text;
    note = _noteController.text;
  }

  @override
  void initState() {
    _contentController.addListener(printLatestValue);
    _noteController.addListener(printLatestValue);
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void clear() {
    _contentController.clear();
    _noteController.clear();
  }

  void handleSubmit() {

    final sp = context.read<TaskRepositoryProvider>();

    if(content.length > 3) {

      final task = Task(
          categoryId: widget.category.id,
          content: content,
          datetime: createdAt.toString(),
          note: note,
      );

      sp.insertTask(task).whenComplete((){
        clear();
        setState(() {});
        print('new task added!');
        Navigator.pop(context);

      });


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'New Task',
                  style: TwoDouTheme.globalTextTheme.headline2,
                ),
                const SizedBox(
                  width: 120,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/x.svg',
                      color: black,
                      width: 30,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: ListView(
                children: [
                  _buildContentField(),
                  _buildNoteField(),
                  _buildCategoryField(context, widget.category),
                  const SizedBox(
                    height: 30,
                  ),
                  // _buildCreateButton(context),
                  Material(
                      color: blue,
                      borderRadius: BorderRadius.circular(25),
                      child: MaterialButton(
                          minWidth: double.infinity,
                          child: const Text(
                            'Create',
                            style:  TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () => handleSubmit()
                      ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentField() {
    const _maxLines = 6;

    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      height: _maxLines * 24.0,
      child:  TextField(
        controller: _contentController,
        cursorColor: blue,
        cursorHeight: 30.0,
        maxLines: _maxLines,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
            labelText: 'What are you planning?',
            labelStyle: TextStyle(fontSize: 25, color: Colors.grey),
            fillColor: white,
            filled: false,
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: white)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: white)),
            border: UnderlineInputBorder(borderSide: BorderSide(color: white))),
      ),
    );
  }


  Widget _buildNoteField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SvgPicture.asset(
            'assets/images/sticky.svg',
            semanticsLabel: 'Note',
            color: grey,
            width: 25,
            height: 25,
          ),
          Container(
            width: 250,
            child: TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Add Note',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: white)),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: white)),
                border:
                    UnderlineInputBorder(borderSide: BorderSide(color: white)),
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryField(BuildContext context, category) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/tag.svg',
            semanticsLabel: 'Category',
            color: grey,
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 10),
          const Text('Category'),
          const SizedBox(width: 20),
          Chip(label: Text(category.title, style: const TextStyle(color: Colors.white),), backgroundColor: Color(getColor(category.color)),)
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return InkWell(
      onTap: (){
        handleSubmit();
      },
      child: Container(
        color: blue,
        height: 50,
        child: const Center(
            child: Text(
          'Create',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 25),
        )),
      ),
    );
  }
}
