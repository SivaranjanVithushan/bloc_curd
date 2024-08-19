import 'dart:developer';

import 'package:bloc_curd/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial(users: [])) {
    on<AddUser>(_addUser);
    on<DeleteUser>(_deleteUser);
    on<UpdateUser>(_updateUser);
  }

  @override
  void onChange(Change<UserListState> change) {
    log(change.toString());
    super.onChange(change);
  }

  void _addUser(AddUser event, Emitter<UserListState> emit) {
    final List<User> updatedUsers = List.from(state.users)..add(event.user);
    emit(UserListUpdated(users: updatedUsers));
  }

  void _deleteUser(DeleteUser event, Emitter<UserListState> emit) {
    final updatedUsers = List<User>.from(state.users)..remove(event.user);
    emit(UserListUpdated(users: updatedUsers));
  }

  void _updateUser(UpdateUser event, Emitter<UserListState> emit) {
    final updatedUsers = List<User>.from(state.users);
    final index = updatedUsers.indexWhere((user) => user.id == event.user.id);
    if (index != -1) {
      updatedUsers[index] = event.user;
      emit(UserListUpdated(users: updatedUsers));
    }
  }
}
