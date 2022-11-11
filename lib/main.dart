import 'package:device_preview/device_preview.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/utils/route/route.dart';
import 'package:expense_tracker/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value){
    runApp(
        DevicePreview(
          enabled: true,
          tools: const[
            ...DevicePreview.defaultTools,
          ],
          builder: (context) {
            return const MyApp();
          }
        )
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>ExpenseProvider(),
      child: Sizer(
        builder: (context,orientation,deviceType){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
           theme: ThemeData(
           textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)
           ),
            initialRoute: RouteName.homeScreen,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}

