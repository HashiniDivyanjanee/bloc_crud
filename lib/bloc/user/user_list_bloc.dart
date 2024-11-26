import 'package:bloc/bloc.dart';
import 'package:bloc_crud/model/user.dart';
import 'package:meta/meta.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial(users: [])) {
    on<AddUser>(_addUser);
    on<DeleteUser>(_deleteUser);
    on<UpdateUser>(_updateUser);
  }

  void _addUser(AddUser event, Emitter<UserListState> emit) {
    final updatedUsers = List<User>.from(state.users)..add(event.user);
    emit(UserListUpdated(users: updatedUsers));
  }

  void _deleteUser(DeleteUser event, Emitter<UserListState> emit) {
    final updatedUsers = state.users.where((u) => u.id != event.user.id).toList();
    emit(UserListUpdated(users: updatedUsers));
  }

  void _updateUser(UpdateUser event, Emitter<UserListState> emit) {
    final updatedUsers = state.users.map((user) {
      return user.id == event.user.id ? event.user : user;
    }).toList();
    emit(UserListUpdated(users: updatedUsers));
  }
}
