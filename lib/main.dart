import 'package:smart_health_reminder/core/const_imports.dart';
import 'package:smart_health_reminder/routes/route_generator.dart';
import 'package:smart_health_reminder/routes/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.ageSelection,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
