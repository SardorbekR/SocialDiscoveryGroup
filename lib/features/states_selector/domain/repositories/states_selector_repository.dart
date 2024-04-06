import 'package:injectable/injectable.dart';
import 'package:social_discovery_group/features/states_selector/data/data_sources/states_selector_datasources.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';

@injectable
class StatesSelectorRepository {
  final StatesSelectorDatasource _dataSource;

  const StatesSelectorRepository({
    required StatesSelectorDatasource dataSource,
  }) : _dataSource = dataSource;

  Future<List<Address>> getCountries() async => await _dataSource.getCountries();

  Future<List<Address>> getStates(String id) async => await _dataSource.getStates(id);
}
