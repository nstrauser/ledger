import 'package:flutter/material.dart';
import 'package:async/async.dart';
import '../models/database_handler.dart';
import '../models/utility.dart';
import '../shared/theme.dart';
import '../models/bill.dart';
import '../widgets/text_field.dart';
import '../widgets/text_field_header.dart';

const kCalcWidth = 65.0;
const kCalcHeight = 45.0;

class DetailsPage extends StatefulWidget {

  final Bill billInEditing;

  DetailsPage([this.billInEditing]);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Bill bill = Bill("", "", "", 1, 0, '');

  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  bool _isNewBill = false;
  final _titleFocus = FocusNode();
  final _amountFocus = FocusNode();
  final _notesFocus = FocusNode();

  String _titleFromInitial;
  String _amountFromInitial;
  String _notesFromInitial;


  var _editableBill;

//  @override
  void initState() {
    _editableBill = widget.billInEditing;
    _titleController.text = _editableBill.title;
    _amountController.text = _editableBill.amount;
    _notesController.text = _editableBill.notes;

    _titleFromInitial = widget.billInEditing.title;
    _amountFromInitial = widget.billInEditing.amount;
    _notesFromInitial = widget.billInEditing.notes;

    if (widget.billInEditing.id == -1) {
      _isNewBill = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_editableBill.id == -1 && _editableBill.title.isEmpty) {
      FocusScope.of(context).requestFocus(_titleFocus);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Bills', style: Theme.of(context).textTheme.headline1),
          elevation: 12,
          backgroundColor: Colors.grey[800],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => moveToLastScreen(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Paid',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Checkbox(
                      value: false,
                      onChanged: (bool value) {
                        checkBillPaid(value);
                      }),
//                  //
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TextFieldHeader(
                        title: 'Title',
                      ),
                      MyTextField(controller: _titleController,
                        onChanged: (str) => updateBillObject(),
                      ),
                    ],
                  ),
                  //
                  //
                  Row(
                    children: <Widget>[
                      TextFieldHeader(
                        title: 'Amount',
                      ),
                      MyTextField(
                        controller: _amountController,
                        onChanged: (str) => updateBillObject(),
                        hintText: '\$0.00',
                      )
                    ],
                  ),
                  //
                  //
                  Row(
                    children: <Widget>[
                      TextFieldHeader(
                        title: 'Due\Date',
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today,
                            color: kBrickRed, size: 36.0),
                        onPressed: () => _selectDate(context),
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 90.0,
                      )),
                      MaterialButton(
                          color: kBackgroundDarker,
                          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                '${_date.month}/${_date.day}/${_date.year}',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          onPressed: () => _selectDate(context)),
                    ],
                  ),
                  //
                  SizedBox(height: 15.0,),
                  //
                  Row(
                    children: <Widget>[
                      TextFieldHeader(
                        title: 'Reminder',
                      ),
                  Switch(
                    activeColor: kBrightBlue,
                      inactiveTrackColor: Colors.grey[600],
                      value: true,
                      onChanged: (bool value) {
                        setState(() {
                          if (value == true) {
                            bill.reminder = 1;
                          } else {
                            bill.reminder = 0;
                          }
                        });
                      }),
                      Expanded(child: SizedBox(height: 10,)),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: kBackgroundDarker,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                        '4 Days Before',
                        style: Theme.of(context).textTheme.headline2,
                      ),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: <Widget>[
                  TextFieldHeader(title: 'Notes',),
                  Expanded(child: SizedBox(height: 5,)),
                ],
              ),
              //
              SizedBox(height: 15.0,),
              //
              TextFormField(
                controller: _notesController,
                  onChanged: (str) => updateBillObject(),
                  maxLines: 12,
                  decoration: InputDecoration(
                      fillColor: kBackgroundDarker,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.8,),
                          borderRadius: BorderRadius.circular(5)))),
            ]),
          ),
        ));
  }

  void updateBillObject() {
    _editableBill.title = _titleController.text;
    _editableBill.amount = _amountController.text;
    _editableBill.notes = _notesController.text;

    if (!(_editableBill.title == _titleFromInitial &&
      _editableBill.amount == _amountFromInitial) ||
        (_isNewBill)) {

      _editableBill.dateLastEdited = DateTime.now();
      CentralStation.updateNeeded = true;
    }
  }



  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void checkBillPaid(value) {
    setState(() {
      if (value == true) {
        bill.billPaid = 1;
      }
    });
  }

  DateTime _date = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) _date = picked;
    setState(() {
      _date = picked;
      bill.dueDate = '${_date.month}/${_date.day}/${_date.year}';
    });
  }
}
