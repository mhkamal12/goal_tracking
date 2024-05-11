import 'package:flutter/material.dart';
import 'package:goal_tracker/model/GoalModel.dart';
import 'package:goal_tracker/utility/Helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class AddOrUpdateGoalScreen extends StatefulWidget {
  const AddOrUpdateGoalScreen({super.key, this.goal});

  final GoalModel? goal;

  @override
  State<AddOrUpdateGoalScreen> createState() => _AddOrUpdateGoalScreenState();
}

class _AddOrUpdateGoalScreenState extends State<AddOrUpdateGoalScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int priority = 1;
  DateTime? date;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.goal != null) {
      final splittedDate = widget.goal!.date.split('/');
      final theDate = DateTime(int.parse(splittedDate[0]),
          int.parse(splittedDate[1]), int.parse(splittedDate[2]));
      setState(() {
        titleController.text = widget.goal!.title;
        descriptionController.text = widget.goal!.description ?? '';
        priority = widget.goal!.priority;
        date = theDate;
      });
    }
    super.initState();
  }

  String formatDate(DateTime date) {
    // format the date to a string (dd/MM/yyyy hh:mm a)
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create Goal'),
              Text(
                'Please fill out the form below to continue.',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 12, 8),
              child: IconButton(
                icon: Icon(Icons.close_rounded, size: 24),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 770,
                            ),
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: titleController,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Task...',
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16, 0, 16, 0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: descriptionController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Description...',
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16, 16, 16, 16),
                                    ),
                                    maxLines: 9,
                                    minLines: 5,
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Priority'),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width - 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 2,
                                        color: Theme.of(context)
                                            .inputDecorationTheme
                                            .enabledBorder!
                                            .borderSide
                                            .color,
                                      ),
                                    ),
                                    child: DropdownButton<int>(
                                      onChanged: (val) {
                                        setState(() {
                                          priority = val!;
                                        });
                                      },
                                      value: priority,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 24,
                                      ),
                                      isExpanded: true,
                                      elevation: 2,
                                      dropdownColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      underline: const SizedBox(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      hint: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          'Select level of priority',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      items: [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text('Low'),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text('Medium'),
                                        ),
                                        DropdownMenuItem(
                                          value: 3,
                                          child: Text('High'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Date'),
                                  InkWell(
                                    onTap: () async {
                                      final _datePickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2050),
                                      );

                                      if (_datePickedDate != null) {
                                        setState(() {
                                          date = _datePickedDate;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 2,
                                          color: Theme.of(context)
                                              .inputDecorationTheme
                                              .enabledBorder!
                                              .borderSide
                                              .color,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 0, 0),
                                          child: Text(
                                            date != null
                                                ? formatDate(date!)
                                                : 'Select a date',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: date == null
                                                  ? Colors.grey
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 770,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                    child: FilledButton(
                      onPressed: () async {
                        try {
                          FocusScope.of(context).unfocus();
                          if (!_formKey.currentState!.validate() ||
                              date == null) {
                            return;
                          }
                          final path = await getDbPath();
                          final db = await openDatabase(path);

                          if (widget.goal == null) {
                            // insert random
                            await db.insert('todos', {
                              'title': titleController.text,
                              'description': descriptionController.text,
                              'priority': priority,
                              'date': date!.toIso8601String(),
                            }).then((value) {
                              Navigator.pop(context, true);
                            });
                          } else {
                            // update
                            await db
                                .update(
                                    'todos',
                                    {
                                      'title': titleController.text,
                                      'description': descriptionController.text,
                                      'priority': priority,
                                      'date': date!.toIso8601String(),
                                    },
                                    where: 'id = ?',
                                    whereArgs: [widget.goal!.id])
                                .then((value) {
                              Navigator.pop(context, true);
                            });
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'An error occurred. Please try again.')));
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
