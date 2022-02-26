import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/components/add_task.dart';

import '../components/category_item.dart';
import '../components/list_tem.dart';
import '../components/side_bar.dart';
import '../data_provider.dart';

class TaskScreen extends StatefulWidget {
  static String routeName = '/task_screen';

  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool isChecked = false;
  bool showDelete = false;

  void getListItemsFromSharedPreferences() async {
    // Create a new Instance of Shared Prefernces
    final prefs = await SharedPreferences.getInstance();
    // Get Data from SharedPrefernces
    final todoListItemsText = prefs.getStringList('todoListItems') ?? [];
    if (todoListItemsText != []) {
      todoListItemsText.forEach((todoListItemText) => {
            setState(() {
              // todoListItems.add(TodoListItem(
              //     text: todoListItemText,
              //     circleColor: Color(0xFF8E13BA),
              //     isChecked: isChecked));
            })
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('agaaain');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              tooltip: 'Increase volume by 10',
              onPressed: () {},
            ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.grey,
              ),
              tooltip: 'Increase volume by 10',
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                      child: Text(
                        'What\'s up, ' +
                            Provider.of<Data>(context).getUserName() +
                            '!',
                        style: TextStyle(
                            fontSize: Provider.of<Data>(context)
                                        .getUserName()
                                        .length >
                                    5
                                ? 35.0 -
                                    (Provider.of<Data>(context)
                                            .getUserName()
                                            .length -
                                        5)
                                : 35.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      child: Text(
                        'CATEGORIES',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        children: [
                          CategoryItem(
                            tasksNumber: 0,
                            categoryName: 'Business',
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          CategoryItem(
                            tasksNumber: 0,
                            categoryName: 'Household  ',
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          CategoryItem(
                            tasksNumber: 0,
                            categoryName: 'Health & Fitness',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 25.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                            child: Text(
                              'TODAY\'S TASKS',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                            child: Text(
                              '' +
                                  Provider.of<Data>(context)
                                      .getTasks()
                                      .length
                                      .toString() +
                                  ' tasks',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ]),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        itemBuilder: (BuildContext context, int index) {
                          return TodoListItem(
                              text: Provider.of<Data>(context)
                                  .getTasks()[index]
                                  .name,
                              onPress: () {
                                Provider.of<Data>(context, listen: false)
                                    .updateTaskStatus(index);
                              },
                              circleColor: Color(0xFF8BA7EE),
                              isChecked: Provider.of<Data>(context)
                                  .getTasks()[index]
                                  .isDone,
                              onDelete: () {
                                Provider.of<Data>(context, listen: false)
                                    .deleteTask(index);
                              });
                        },
                        itemCount: Provider.of<Data>(context).getTasks().length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                // we should pass a Callback function to submit DATA from Modal to up Screen
                child: AddTaskScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF031956),
      ),
    );
  }
}
