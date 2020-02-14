import 'dart:convert';

class Bill {

  int _id;
  String _title;
  String _dueDate;
  String _amount;
  int _reminder;
//  int _isArchived = 0;
  int _billPaid;
  String _notes;

  Bill(this._title, this._dueDate, this._amount, this._reminder, this._billPaid, this._notes);

  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
      'title': utf8.encode(_title),
      'dueDate': utf8.encode(_dueDate),
      'amount': utf8.encode(_amount),
      'reminder': _reminder,
      'billPaid': _billPaid,
//      'isArchived': _isArchived
      'notes': _notes,

    };
    if(forUpdate) {
      data['id'] = this.id;
    }
    return data;
  }

  int epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }

//  void archiveThisNote() {
//    isArchived = 1;
//  }

  @override toString() {
    return {
      'id': _id,
      'title': _title,
      'dueDate': _dueDate,
      'amount': _amount,
      'billPaid': _billPaid,
      'reminder': _reminder,
//      'isArchived': isArchived
      'notes': _notes,
    }.toString();
  }

  int get id => _id;
  String get title => _title;
  String get dueDate => _dueDate;
  String get amount => _amount;
// int get isArchived => _isArchived;
  int get billPaid => _billPaid;
  int get reminder => _reminder;
  String get notes => _notes;

  set title(String newTitle) {
    this._title = newTitle;
  }

  set dueDate(String newDueDate) {
    this._dueDate = newDueDate;
  }

  set amount(String newAmount) {
    this._amount = newAmount;
  }

  set billPaid(int newBillPaid) {
    this._billPaid = newBillPaid;
  }

  set reminder(int newReminder) {
    this._reminder = newReminder;
  }

//  set isArchived(int newIsArchived) {
//    this._isArchived = newIsArchived;
//  }

  set notes(String newNotes) {
    this._notes = newNotes;
  }
}