import 'package:flutter/material.dart';
import 'package:social_discovery_group/features/states_selector/presentation/bloc/states_selector_bloc.dart';
import 'package:social_discovery_group/features/states_selector/presentation/widgets/app_button.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.statesSelectorBloc, super.key});

  final StatesSelectorBloc statesSelectorBloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'An error occurred. Please try again later.',
            style: TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 150,
            child: AppButton(
              buttonText: 'Retry',
              onTap: () => statesSelectorBloc.add(const GetCountries()),
              backgroundColor: Colors.green[300],
              textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
