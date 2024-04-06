part of 'states_selector_bloc.dart';

sealed class StatesSelectorState extends Equatable {
  const StatesSelectorState();
}

final class StatesSelectorInitial extends StatesSelectorState {
  @override
  List<Object> get props => [];
}

final class FetchingCountries extends StatesSelectorState {
  const FetchingCountries();

  @override
  List<Object> get props => [];
}

final class FetchingStates extends StatesSelectorState {
  const FetchingStates();

  @override
  List<Object> get props => [];
}

final class CountriesFetched extends StatesSelectorState {
  final List<Address> countries;

  const CountriesFetched({required this.countries});

  @override
  List<Object> get props => [countries];
}

final class StatesFetched extends StatesSelectorState {
  final List<Address> states;

  const StatesFetched({required this.states});

  @override
  List<Object> get props => [states];
}

final class StatesSelectorError extends StatesSelectorState {
  final String message;

  const StatesSelectorError({required this.message});

  @override
  List<Object> get props => [message];
}
