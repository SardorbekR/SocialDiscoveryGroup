import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_discovery_group/core/shared/error_handler.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';
import 'package:social_discovery_group/features/states_selector/domain/repositories/states_selector_repository.dart';

part 'states_selector_event.dart';
part 'states_selector_state.dart';

@injectable
class StatesSelectorBloc extends Bloc<StatesSelectorEvent, StatesSelectorState> {
  StatesSelectorBloc({required StatesSelectorRepository repository})
      : _repository = repository,
        super(StatesSelectorInitial()) {
    on<GetCountries>(_getCountries);
    on<GetStates>(_getStates);
  }

  final StatesSelectorRepository _repository;

  Future<void> _getCountries(GetCountries event, Emitter<StatesSelectorState> emit) async {
    emit(const FetchingCountries());

    await _repository.getCountries().errorHandler(
          onSuccess: (countries) async => emit(CountriesFetched(countries: countries)),
          onError: (errorMsg) => emit(StatesSelectorError(message: errorMsg)),
        );
  }

  Future<void> _getStates(GetStates event, Emitter<StatesSelectorState> emit) async {
    emit(const FetchingStates());

    await _repository.getStates(event.countryId.toString()).errorHandler(
          onSuccess: (states) async => emit(StatesFetched(states: states)),
          onError: (errorMsg) => emit(StatesSelectorError(message: errorMsg)),
        );
  }
}
