import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../utility/Helper.dart';
import 'AddGoalScreen.dart';
import '../model/GoalModel.dart';
import 'SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GoalModel> _goals = [];
  Database? db;

  @override
  void initState() {
    _getTodos();
    super.initState();
  }

  void _getTodos([DateTime? startDate, DateTime? endDate]) async {
    final path = await getDbPath();

    db = await openDatabase(path);
    List<Map> list = [];
    if (startDate == null && endDate == null) {
      list = await db!.rawQuery('SELECT * FROM todos');
    } else {
      list = await db!.rawQuery(
          'SELECT * FROM todos WHERE date BETWEEN ? AND ?',
          [startDate!.toIso8601String(), endDate!.toIso8601String()]);
    }

    setState(() {
      _goals = list
          .map((e) => GoalModel.fromMap(e as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();
    });
  }

  // get priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Goals'),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                try {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SettingsScreen();
                  }));
                } catch (e) {
                  print(e);
                }
              },
            );
          }),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.today),
                tooltip: 'Today\'s Goals',
                onPressed: () async {
                  final DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  );
                  if (picked == null) {
                    _getTodos();
                    return;
                  }
                  ;

                  _getTodos(picked.start, picked.end);
                },
              );
            }),
          ],
        ),
        body: _goals.isEmpty
            ? Center(
                child: Text('No goals found'),
              )
            : ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  return Card.filled(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddOrUpdateGoalScreen(
                            goal: _goals[index],
                          );
                        })).then((value) {
                          if (value == true) {
                            _getTodos();
                          }
                        });
                      },
                      contentPadding: const EdgeInsets.only(right: 0, left: 13),
                      title: Text(_goals[index].title),
                      subtitle: Text(_goals[index].date),
                      leading: CircleAvatar(
                        backgroundColor:
                            getPriorityColor(_goals[index].priority),
                        radius: 7,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outlined),
                        onPressed: () async {
                          // show a dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete Goal'),
                                content: const Text(
                                    'Are you sure you want to delete this goal?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await db!.delete(
                                        'todos',
                                        where: 'id = ?',
                                        whereArgs: [_goals[index].id],
                                      ).then((value) {
                                        Navigator.pop(context);
                                        _getTodos();
                                      });
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddOrUpdateGoalScreen();
            })).then((value) {
              if (value == true) {
                _getTodos();
              }
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}
