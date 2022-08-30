import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

FirebaseStorage storage = FirebaseStorage.instance;

const primaryColor = Color(0xff739F69);
const secondaryColor = Color(0xffFEBC70);
const defaultProfilePicUrl = "https://firebasestorage.googleapis.com/v0/b/test-bad6f.appspot.com/o/user.png?alt=media&token=e0b840df-a35f-4974-99de-902a57a865b6";

class LoadingWidget extends SpinKitFadingCircle {
  const LoadingWidget({Key? key}) : super(key: key, color: secondaryColor);
}
