import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:expense_tracker/components/custom_widget.dart';
import 'package:expense_tracker/database/entry_save.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/resources/color.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  List<String>account=["Expense","Income"];
  final accountSelected=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController amountController=TextEditingController(text: "");
  bool isEnable=false;
  String totalAmount="";
  DateTime dateTime=DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  void dispose() {
    super.dispose();
    accountSelected.dispose();
    amountController.dispose();
    dateController.dispose();
    timeController.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final expenseProvider=Provider.of<ExpenseProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:AppColor.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(right: 4.w,left: 4.w,top: 2.h),
          child: Column(
            children: [
              textField(hintText: "Title",length: 30,controller:titleController,lines: 1,textInputAction: TextInputAction.next,onPress:(value){
                if(value.length==30){
                  Utils.flushBar("Title limit was only 30 characters", context);
                }
                validateButton();
              }),
              SizedBox(height: 1.h,),
              textField(hintText: "Description",length: 100,controller: descriptionController,lines: 6,onPress: (value){
                if(value.length==100){
                  Utils.flushBar("Description limit was only 100 characters", context);
                }
                validateButton();
              }),
              SizedBox(height: 1.h,),
              Row(
                children: [
                  pickerContainer(icon: Icons.date_range_outlined, onPress:()=>selectedDate(context)),
                  SizedBox(width: 2.w,),
                  Expanded(
                    child: textField(hintText: "Date",read: true,controller: dateController)
                  ),
                ],
              ),
               SizedBox(height: 1.h,),
              Row(
                children: [
                  pickerContainer(icon: Icons.access_time, onPress: ()=>selectedTimes(context)),
                  SizedBox(width: 2.w,),
                  Expanded(
                    child: textField(hintText: "Time",read: true,controller: timeController,onPress: (value){
                      validateButton();
                    })
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              CustomDropdown(items: account, hintText: "Expense",controller: accountSelected,selectedStyle: const TextStyle(color: Colors.black),onChanged: (value){
                validateButton();
               // setState(() {});
              },),
              SizedBox(height: 1.h,),
              textField(hintText: "Amount",controller: amountController,cursor: true,read: true),
              SizedBox(height: 1.h,),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     customContainer(number: "1",onPress: (){
                       setAmount(amount: "1");
                     }),
                      customContainer(number: "2",onPress: (){
                        setAmount(amount: "2");
                      }),
                      customContainer(number: "3",onPress: (){
                        setAmount(amount: "3");
                      }),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customContainer(number: "4",onPress: (){
                        setAmount(amount: "4");
                      }),
                      customContainer(number: "5",onPress: (){
                        setAmount(amount: "5");
                      }),
                      customContainer(number: "6",onPress: (){
                        setAmount(amount: "6");
                      }),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customContainer(number: "7",onPress: (){
                        setAmount(amount: "7");
                      }),
                      customContainer(number: "8",onPress: (){
                        setAmount(amount: "8");
                      }),
                      customContainer(number: "9",onPress: (){
                        setAmount(amount: "9");
                      }),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customContainer(number: "0",onPress: (){
                        setAmount(amount: "0");
                      }),
                       SizedBox(width: 1.w),
                      Container(
                        width: 31.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.buttonColor,
                        ),
                        child: TextButton(
                          onPressed: (){
                            amountDelete();
                            },
                          child:  Text("Delete",style: TextStyle(color: Colors.grey[200],fontSize: 18),),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: isEnable?AppColor.floatingButtonColor:AppColor.textFieldColor,
          onPressed: isEnable? ()async{
           final id=await DatabaseHelper.instance.insert(
              ExpenseModel(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  date: dateController.text.trim(),
                  time: timeController.text.trim(),
                  expenseField: accountSelected.text.trim(),
                  amount: amountController.text.trim(),
              )
            );
           final query=await DatabaseHelper.instance.queryAll();
           log(query.toString());
           expenseProvider.mapType();
           if(mounted)Navigator.pop(context,query);
          }:null,
          child: Icon(Icons.done,color:isEnable?AppColor.textFieldColor:AppColor.hintColor,),
        ),
      ),
    );
  }

  Future<void> selectedDate(BuildContext context) async{
    FocusScope.of(context).unfocus();
    DateTime? pickDate= await showDatePicker(
      context: context,
      initialDate:dateTime,
      firstDate: DateTime(2001),
      lastDate: DateTime(2030),
    );
    if(pickDate!=null){
      setState((){
        dateController.text=DateFormat("dd MMMM, yyyy").format(pickDate);
        validateButton();
      });
    }
  }

  Future<void>selectedTimes(BuildContext context)async{
    FocusScope.of(context).unfocus();
    TimeOfDay? timeOfDay=await showTimePicker(
        context: context,
        initialTime: time
    );
    if(timeOfDay!=null){
      setState((){
        timeController.text=timeOfDay.format(context) ;
        validateButton();
      });
    }
  }

  void setAmount({required String amount}){
    if(checkCursor() == -1){
      totalAmount += amount;
      amountController.text=totalAmount;
    }
    else{
       final cursorPosition=checkCursor();
      String prefixText=amountController.text.substring(0,checkCursor());
      String suffixText=amountController.text.substring(checkCursor());
      String newText=amount;
      totalAmount=prefixText+newText+suffixText;
      amountController.text=totalAmount;
      amountController.selection=TextSelection(baseOffset: cursorPosition+1, extentOffset: cursorPosition+1);
    }

      if(amountController.text.isNotEmpty){
        validateButton();
      }
  }

  void amountDelete(){
    if(amountController.text != "" && checkCursor() == -1){
     totalAmount=totalAmount.substring(0,totalAmount.length-1);
     amountController.text=totalAmount;
    }
    else if(amountController.text != "" && checkCursor() != 0){
      final cursorPosition=checkCursor();
      String prefixText=amountController.text.substring(0,checkCursor()-1);
      String suffixText=amountController.text.substring(checkCursor());
      totalAmount=prefixText+suffixText;
      amountController.text=totalAmount;
      amountController.selection=TextSelection(baseOffset: cursorPosition-1, extentOffset:cursorPosition-1);
    }
  }

  int checkCursor(){
    var cursorPosition=amountController.selection.base.offset;
    return cursorPosition;
  }

  void validateButton() {
    bool isValid = true;
    isValid = titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        dateController.text.isNotEmpty && timeController.text.isNotEmpty &&
        amountController.text.isNotEmpty && accountSelected.text.isNotEmpty;
    setState(() {
      isEnable = isValid;
    });
  }
}
