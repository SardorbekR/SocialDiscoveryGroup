part of 'states_selector_bloc.dart';

sealed class StatesSelectorEvent extends Equatable {
  const StatesSelectorEvent();
}

class GetCountries extends StatesSelectorEvent {
  const GetCountries();

  @override
  List<Object> get props => [];
}

class GetStates extends StatesSelectorEvent {
  final int countryId;

  const GetStates({required this.countryId});

  @override
  List<Object> get props => [countryId];
}
