import 'package:aptcoder/core/widgets/skeleton.dart';
import 'package:aptcoder/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:aptcoder/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:aptcoder/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:aptcoder/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAppBar extends StatelessWidget implements PreferredSize {
  final double _height;
  const AdminAppBar(
    this._height, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration:
          const BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: secondaryColor,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            )),
            actions: [
              IconButton(
                  onPressed: () => context.read<AuthenticationBloc>().add(LogoutEvent()),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ))
            ],
            title: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminLoadedState) {
                  return RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Your Dashboard", style: Theme.of(context).textTheme.headlineMedium),
                  ]));
                } else {
                  return BaseShimmerBox(
                    width: width * 0.6,
                    height: preferredSize.height * 0.15,
                    color: Colors.grey.shade700,
                  );
                }
              },
            ),
            leadingWidth: width * 0.18,
            toolbarHeight: preferredSize.height * 0.4,
            leading: SizedBox(
              height: preferredSize.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipOval(
                  child: BlocBuilder<AdminBloc, AdminState>(
                    builder: (context, state) {
                      if (state is AdminLoadedState) {
                        return Image.network(
                          (state).admin.profilePic ?? defaultProfilePicUrl,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return BaseShimmerBox(
                          color: Colors.grey.shade700,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: preferredSize.height * 0.12),
          BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              if (state is AdminLoadedState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: width * 0.4),
                        child: Text(state.admin.name, style: Theme.of(context).textTheme.headlineSmall)),
                    SizedBox(
                      width: width * 0.07,
                    ),
                    Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width * 0.4),
                          child: Text("Total courses", style: Theme.of(context).textTheme.titleMedium),
                        ),
                        SizedBox(
                          height: _height * 0.04,
                        ),
                        BlocBuilder<CoursesBloc, CoursesState>(
                          builder: (context, state) {
                            if (state is CoursesLoadedState) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: width * 0.4),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.add_chart_rounded,
                                      ),
                                    ),
                                    Text(state.courses.length.toString(/*  */),
                                        style: Theme.of(context).textTheme.headlineMedium),
                                  ],
                                ),
                              );
                            } else {
                              return BaseShimmerBox(
                                width: width * 0.25,
                                height: preferredSize.height * 0.10,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ]),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseShimmerBox(
                          width: width * 0.35,
                          height: preferredSize.height * 0.1,
                        ),
                        SizedBox(
                          height: preferredSize.height * 0.02,
                        ),
                        BaseShimmerBox(
                          width: width * 0.35,
                          height: preferredSize.height * 0.10,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseShimmerBox(
                          width: width * 0.25,
                          height: preferredSize.height * 0.1,
                        ),
                        SizedBox(
                          height: preferredSize.height * 0.02,
                        ),
                        BaseShimmerBox(
                          width: width * 0.25,
                          height: preferredSize.height * 0.10,
                        ),
                      ],
                    ),
                  ]),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget get child {
    return AppBar(
      backgroundColor: Colors.white,
      title: SizedBox(
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminLoadedState) {
              return Image.network(
                (state).admin.profilePic ?? defaultProfilePicUrl,
                fit: BoxFit.fill,
              );
            } else {
              return const BaseShimmerBox();
            }
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
