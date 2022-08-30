import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/login/data/core/exception.dart';
import 'package:aptcoder/features/login/data/datasources/remote/authentication_data_source.dart';
import 'package:aptcoder/features/login/domain/core/failure.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/login/domain/repositories/authentication_repository.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserCredential>> login() async {
    try {
      final user = await remoteDataSource.login();
      if (user.user != null) {
        return Right(user);
      } else {
        return Left(UserNotFound());
      }
    } on UserNotFoundException catch (e) {
      return Left(UserNotFound());
    }
  }

  @override
  Future<Either<Failure, Usertype>> getUsertype(UserCredential creds) async {
    try {
      final type = await remoteDataSource.getUserType(creds);
      return Right(type);
    } on UserNotFoundException catch (e) {
      return Left(UserNotFound());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Student>> registerNewStudent(Student student) async {
    try {
      return Right((await remoteDataSource.addStudent(student)));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await remoteDataSource.logout());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getInitialUser();
      return Right(user);
    } on UserNotFoundException catch (e) {
      return Left(UserNotFound());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  Future<Either<Failure, Usertype>> getUserType(User user) async {
    try {
      return Right(await remoteDataSource.getCurrentUserType(user));
    } on InvalidUserException catch (e) {
      return Left(InvalidUser());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}

