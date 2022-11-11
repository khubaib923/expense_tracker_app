import 'package:expense_tracker/utils/route/route_name.dart';
import 'package:expense_tracker/view/entry_screen.dart';
import 'package:expense_tracker/view/home_screen.dart';
import 'package:flutter/material.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context)=>const HomeScreen());
      case RouteName.entryScreen:
        return MaterialPageRoute(builder: (context)=>const EntryScreen());
      default:
        return MaterialPageRoute(builder: (context)=>const Scaffold(
          body: Center(child: Text("No route defined"),)
        )
        );
    }
  }
}