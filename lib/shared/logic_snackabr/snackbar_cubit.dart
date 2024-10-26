import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'snackbar_state.dart';

class SnackbarCubit extends Cubit<SnackbarState> {
  SnackbarCubit() : super(SnackbarInitial());

  void showSnackbar(String title, String message, {bool isSuccess = true}) {
    emit(SnackbarShow(title: title, message: message, isSuccess: isSuccess));
  }

  void hideSnackbar() {
    emit(SnackbarInitial());
  }
}
