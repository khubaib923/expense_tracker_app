import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/resources/color.dart';
import 'package:expense_tracker/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formatter = NumberFormat('#,##,000');

  @override
  void initState() {
    super.initState();
    final provider=Provider.of<ExpenseProvider>(context,listen: false);
    provider.mapType();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(context, RouteName.entryScreen).then((value){
                            if(value==null) {
                              return;
                            } else{
                              setState(() {});
                            }
                  });
                  },
                child: Container(
                  padding:
                       EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.floatingButtonColor,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        size: 15,
                      ),
                      Text(
                        "Add",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body:Consumer<ExpenseProvider>(builder: (context,value,child){
          return  Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                      PieChart(
                      dataMap:  {
                        "Expense":double.parse(value.expenseSave.toString()),
                        "Income":double.parse(value.incomeSave.toString()),
                        "Saving":double.parse(value.saving.toString()),
                      },
                      colorList:  [AppColor.buttonColor,AppColor.expenseButtonColor,AppColor.savingButtonColor],
                      ringStrokeWidth: 15,
                      chartValuesOptions: const ChartValuesOptions(showChartValues: false),
                      chartType: ChartType.ring,
                      chartRadius: MediaQuery.of(context).size.width/2.4,
                    )
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      // ignore: unnecessary_null_comparison
                      if (value.getData() != null)
                        buildExpenseList(value.getData()),
                    ],
                  ),
                ),
              )
            ],
          );
        })
      ),
    );
  }
  Widget buildExpenseList(data) {
    return Expanded(
      child: FutureBuilder(
          future: data,
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  //reverse: true,
                  //shrinkWrap: true,
                  itemCount: snapshot.requireData.length,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> data=snapshot.requireData.reversed.toList();
                    return Container(
                      margin:  EdgeInsets.symmetric(vertical: 0.4.h),
                      padding: EdgeInsets.symmetric(horizontal:4.w ,vertical: 1.7.h),
                      decoration: BoxDecoration(color: AppColor.textFieldColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(50), color:AppColor.textButtonColor,),
                            child:data[index]["expenseField"]=="Income"? Image.asset("asset/right-arrow.png",height: 3.h,color:AppColor.expenseButtonColor,):Image.asset("asset/left-arrow.png",height: 3.h,color:AppColor.buttonColor,),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index]["title"],style: TextStyle(fontWeight: FontWeight.w600,color: AppColor.amountColor)),
                              SizedBox(
                                width: 50.w,
                                child: AutoSizeText(
                                    data[index]["description"],
                                    minFontSize: 13,
                                    maxFontSize: 13,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:TextStyle(color:AppColor.descriptionColor)

                                ),
                              ),
                              Text("${data[index]["date"]} at ${data[index]["time"]}",style: TextStyle(color: AppColor.hintColor,fontSize: 9.sp),),
                            ],
                          ),
                          Text(formatter.format(double.parse(data[index]["amount"])),style: TextStyle(color:AppColor.amountColor,fontWeight: FontWeight.w600),),
                        ],
                      ),
                    );
                  });
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
