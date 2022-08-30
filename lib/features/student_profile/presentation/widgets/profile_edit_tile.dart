import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_profile/presentation/bloc/student_profile_bloc.dart';
import 'package:aptcoder/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditTile extends StatelessWidget {
  final String? title;
  final String label;
  final Function(String) onEditConfirm;

  final TextEditingController controller = TextEditingController();

  final Student student;
  final TextInputType inputType;
  ProfileEditTile(
      {super.key,
      required this.title,
      required this.label,
      required this.onEditConfirm,
      required this.student,
      required this.inputType});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        ProfileEditPrompt(
          constraints: BoxConstraints(maxWidth: width * 0.4),
          title: title,
          label: label,
          controller: controller,
          onEditConfirm: onEditConfirm,
          student: student,
          inputType: inputType,
        ),
        const Spacer(),
        SizedBox(
          width: width * 0.25,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(20),
                  left: Radius.circular(20),
                ),
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProfileEditPrompt extends StatelessWidget {
  final String? title;
  final String label;
  final TextEditingController controller;
  final Function(String value) onEditConfirm;
  final BoxConstraints? constraints;
  final Student student;

  final TextInputType inputType;

  const ProfileEditPrompt(
      {super.key,
      this.title,
      required this.onEditConfirm,
      required this.label,
      this.constraints,
      required this.controller,
      required this.student,
      required this.inputType});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        BlocBuilder<StudentProfileBloc, StudentProfileState>(
          builder: (context, state) {
            if (state is EditProfileState && label == state.label) {
              return ConstrainedBox(
                constraints: constraints ??
                    BoxConstraints(
                      maxWidth: width * 0.5,
                    ),
                child: TextFormField(
                  keyboardType: inputType,
                  autofocus: true,
                  controller: controller..text = title ?? "",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              );
            } else {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width * 0.5,
                ),
                child: title != null
                    ? Text(
                        title!,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    : Text(
                        "enter $label",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
              );
            }
          },
        ),
        BlocBuilder<StudentProfileBloc, StudentProfileState>(builder: (context, state) {
          if (state is EditProfileState && label == state.label) {
            if (state is EditProfileState && label == state.label) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.read<StudentProfileBloc>().add(CancelUpdateMode(state.student));
                      },
                      child: Icon(color: Colors.red, size: 24, Icons.cancel)),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Hey wait"),
                              content: const Text("Confirm Edit"),
                              actions: [
                                ElevatedButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text("Confirm"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    onEditConfirm(controller.text);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(color: primaryColor, size: 24, Icons.check)),
                ],
              );
            }
          }

          return IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.read<StudentProfileBloc>().add(EditProfile(label, student));
              });
        })
      ],
    );
  }
}
