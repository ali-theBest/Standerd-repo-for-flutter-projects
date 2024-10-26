import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic_snackabr/snackbar_cubit.dart';

class CustomSnackbar extends StatelessWidget {
  final Widget child;

  const CustomSnackbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SnackbarCubit, SnackbarState>(
      listener: (context, state) {
        if (state is SnackbarShow) {
          final color = state.isSuccess ? Colors.green[100] : Colors.red[100];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(state.message),
                ],
              ),
              backgroundColor: color,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: child,
    );
  }
}
