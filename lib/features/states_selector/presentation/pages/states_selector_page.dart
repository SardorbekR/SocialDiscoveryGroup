import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';
import 'package:social_discovery_group/features/states_selector/presentation/bloc/states_selector_bloc.dart';
import 'package:social_discovery_group/features/states_selector/presentation/widgets/app_dropdown.dart';
import 'package:social_discovery_group/features/states_selector/presentation/widgets/dropdown_shimmer.dart';
import 'package:social_discovery_group/features/states_selector/presentation/widgets/error_page.dart';

class StatesSelectorPage extends StatefulWidget {
  const StatesSelectorPage({super.key});

  @override
  State<StatesSelectorPage> createState() => _StatesSelectorPageState();
}

class _StatesSelectorPageState extends State<StatesSelectorPage> {
  List<Address> countries = <Address>[];
  List<Address> states = <Address>[];
  late StatesSelectorBloc statesSelectorBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    statesSelectorBloc = context.read<GetIt>().get<StatesSelectorBloc>()..add(const GetCountries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Discovery Group'),
      ),
      body: BlocConsumer<StatesSelectorBloc, StatesSelectorState>(
        bloc: statesSelectorBloc,
        listener: (context, state) {
          if (state is CountriesFetched) {
            countries = state.countries;
          }

          if (state is StatesFetched) {
            states = state.states;
          }
        },
        builder: (context, state) {
          if (state is StatesSelectorError) {
            return ErrorPage(statesSelectorBloc: statesSelectorBloc);
          }

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 100),

                if (state is FetchingCountries)
                  const DropdownShimmer()
                else if (countries.isNotEmpty)
                  AppDropdownMenu(
                    label: 'Countries',
                    onSelected: (country) {
                      if (country != null) statesSelectorBloc.add(GetStates(countryId: country.id));
                    },
                    items: countries,
                  ),

                const SizedBox(height: 40),

                if (state is FetchingStates)
                  const DropdownShimmer()
                else if (states.isNotEmpty)
                  AppDropdownMenu(
                    label: 'States',
                    onSelected: (states) {},
                    items: states,
                  ),

                //
              ],
            ),
          );
        },
      ),
    );
  }
}
