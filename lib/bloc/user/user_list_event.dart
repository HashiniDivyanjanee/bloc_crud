part of 'user_list_bloc.dart';

@immutable
abstract class UserListEvent {}

class AddUser extends UserListEvent{
  final User user;
  AddUser({required this.user});
}

class DeleteUser extends UserListEvent{
  final User user;
  DeleteUser({required this.user});
}

class UpdateUser extends UserListEvent{
  final User user;
  UpdateUser({required this.user});
}

