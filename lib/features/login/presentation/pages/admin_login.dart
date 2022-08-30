import 'package:aptcoder/core/error/widgets/error.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:aptcoder/features/login/presentation/pages/student_login.dart';
import 'package:aptcoder/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UnAuthorizedState) {
            showDialog(
                context: context,
                builder: ((context) => Dialog(
                      child: ErrorDisplay(
                        state.error,
                        height: height * 0.4,
                        width: width * 0.7,
                      ),
                    )));
          }
        },
        builder: ((context, state) {
          if (state is AuthorizationPromptState || state is UnAuthorizedState || state is LogoutState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Admin  Login",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: SizedBox(
                      height: height * 0.4,
                      width: width * 0.8,
                      child: Image.asset(
                        "assets/images/admin.jpg",
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(secondaryColor),
                          fixedSize: MaterialStateProperty.all(Size(
                            width * 0.5,
                            height * 0.05,
                          )),
                          elevation: MaterialStateProperty.all(0)),
                      onPressed: () => authBloc.add(LoginRequestEvent(Usertype.admin)),
                      child: const Text(
                        "Login with google",
                      )),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(primaryColor),
                          fixedSize: MaterialStateProperty.all(Size(
                            width * 0.5,
                            height * 0.05,
                          )),
                          elevation: MaterialStateProperty.all(0)),
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const StudentLoginPage()), (route) => false),
                      child: const Text("Login as student")),
                ),
              ],
            );
          } else if (state is LoginProgressState || state is AuthenticationInitialState) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "trying to \n Log you in",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(height: 1.2),
                    ),
                    const LoadingWidget(),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: LoadingWidget(),
            );
          }
        }),
      ),
    );
  }
}
