part of 'user_list_bloc.dart';

@immutable
abstract class UserListState {
  final List<User> users;
  const UserListState({required this.users});
}

class UserListInitial extends UserListState {
  const UserListInitial({required List<User> users}) : super(users: users);
}

class UserListUpdated extends UserListState {
  const UserListUpdated({required List<User> users}) : super(users: users);
}
