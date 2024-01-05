part of 'users_cubit.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class GetAcceptedUsersLoading extends UsersState {}

class GetAcceptedUsersSuccess extends UsersState {}

class GetAcceptedUsersFailure extends UsersState {}

class GetAcceptedUsersTimeOut extends UsersState {}

class GetPendingUsersLoading extends UsersState {}

class GetPendingUsersSuccess extends UsersState {}

class GetPendingUsersFailure extends UsersState {}

class GetPendingUsersTimeOut extends UsersState {}
