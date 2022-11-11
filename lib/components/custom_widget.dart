import 'package:expense_tracker/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget textField({int? length,int? lines,required String hintText,TextEditingController? controller,TextInputAction? textInputAction,ValueChanged<String>? onPress,bool? cursor,bool? read}){
  return  TextField(
    controller: controller,
    readOnly:read ?? false,
    showCursor: cursor,
    textInputAction: textInputAction,
    // keyboardType:TextInputType.none ,
    maxLength: length,
    // scrollPadding: const EdgeInsets.only(bottom: 40),
    maxLines: lines,
    onChanged: onPress,
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      counterText: "",
      fillColor: AppColor.textFieldColor,
      hintStyle: TextStyle(color: AppColor.hintColor),
      contentPadding:  EdgeInsets.symmetric(vertical: 1.h,horizontal: 3.w),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
      ),
    ),
  );
}


Widget pickerContainer({required IconData icon,required VoidCallback onPress}){
  return  Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textFieldColor
    ),
    child: IconButton(
      onPressed: onPress,
      icon: Icon(Icons.date_range_outlined,color: AppColor.hintColor,size: 30,),
    ),
  );
}

Widget customContainer({required String number,required VoidCallback onPress}){
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal: 0.8.w,vertical: 0.5.h),
    child: Container(
      width: 14.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.textFieldColor
      ),
      child: TextButton(
        onPressed: onPress,
        child:  Text(number,style: TextStyle(color:AppColor.hintColor,fontSize: 16.sp),),
      ),
    ),
  );
}



