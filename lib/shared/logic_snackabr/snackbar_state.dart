part of 'snackbar_cubit.dart';

@immutable
abstract class SnackbarState {}

class SnackbarInitial extends SnackbarState {}

class SnackbarShow extends SnackbarState {
  final String title;
  final String message;
  final bool isSuccess;

  SnackbarShow({required this.title, required this.message, this.isSuccess = true});
}
