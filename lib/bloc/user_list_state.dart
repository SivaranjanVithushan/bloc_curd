part of 'user_list_bloc.dart';

abstract class UserListState {
  List<User> users;
  UserListState({required this.users});
}

final class UserListInitial extends UserListState {
  UserListInitial({required super.users});
}

final class UserListUpdated extends UserListState {
  UserListUpdated({required super.users});
}
