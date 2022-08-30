import 'package:aptcoder/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:aptcoder/features/admin/presentation/pages/admin_panel.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:aptcoder/features/login/presentation/pages/student_login.dart';
import 'package:aptcoder/features/student_dashboard/presentation/bloc/student_dashboard_bloc.dart';
import 'package:aptcoder/features/student_dashboard/presentation/pages/homepage.dart';
import 'package:aptcoder/firebase_options.dart';
import 'package:aptcoder/core/injection_container.dart';
import 'package:aptcoder/core/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(BlocProvider<AuthenticationBloc>(
      lazy: false, create: (context) => AuthenticationBloc(sl(), sl(), sl(),sl())..add(InitialAuthCheckEvent()), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Aptcoder',
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: secondaryColor,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
            headlineSmall: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            titleLarge: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            titleMedium: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            titleSmall: TextStyle(
              fontSize: 14.0,
            ),
            labelLarge: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
            labelMedium: TextStyle(
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
            ),
            labelSmall: TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)))),
      home: const StudentLoginPage(),
      builder: ((context, child) => BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: ((context, state) => {
                if (state is LogoutState)
                  {
                    _navigator.pushAndRemoveUntil(
                        MaterialPageRoute(builder: ((context) => const StudentLoginPage())), (route) => false)
                  }
                else if (state is AuthorizedState)
                  {
                    if (state.user.type == Usertype.student)
                      {
                        _navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => BlocProvider<StudentDashboardBloc>(
                                    create: (context) => StudentDashboardBloc(context.read(), sl(), sl(), sl())
                                      ..add(FetchStudentEvent()),
                                    child: const HomePage()))),
                            (route) => false)
                      }
                    else
                      {
                        _navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => BlocProvider<AdminBloc>(
                                    create: (context) => AdminBloc(context.read(), sl(), sl())..add(FetchAdminEvent()),
                                    child: const AdminPanel()))),
                            (route) => false)
                      }
                  }
                // else if (state is NewUserAuthenticated && state.type == Usertype.student)
                //   {
                //     _navigator.pushAndRemoveUntil(
                //         MaterialPageRoute(
                //             builder: ((context) => BlocProvider<StudentBloc>(
                //                 create: (context) =>
                //                     StudentBloc(context.read<AuthenticationBloc>())..add(AddStudentEvent(state.user)),
                //                 child: const HomePage()))),
                //         (route) => false)
                //   }
                // else if (state is NewUserAuthenticated && state.type == Usertype.admin)
                //   _navigator.pushAndRemoveUntil(
                //       MaterialPageRoute(
                //           builder: ((context) => BlocProvider<AdminBloc>(
                //               create: (context) =>
                //                   AdminBloc(context.read<AuthenticationBloc>())..add(AddAdminEvent(state.user)),
                //               child: const AdminPanel()))),
                //       (route) => false)
              }),
          child: child)),
      onGenerateRoute: (_) => MaterialPageRoute(builder: ((context) => const StudentLoginPage())),
      debugShowCheckedModeBanner: false,
    );
  }
}
