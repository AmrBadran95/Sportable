import 'package:sportable/Services/cubits/countries_cubit/countries_cubit.dart';
import 'package:sportable/Services/cubits/location_cubit/location_cubit.dart';
import 'package:sportable/Services/cubits/search_countries_cubit/search_countries_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/data/models/countries_model.dart';
import 'package:sportable/data/repos/countries_repo.dart';
import 'package:sportable/presentation/screens/leagues_screen.dart';
import 'package:sportable/presentation/widgets/layout_with_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportable/presentation/widgets/search_field.dart';

class CountriesScreen extends StatelessWidget {
  CountriesScreen({super.key});
  final SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => CountriesCubit(CountriesRepo())..fetchCountries(),
          ),
          BlocProvider(create: (context) => SearchCountriesCubit()),
          BlocProvider(create: (context) => LocationCubit()),
        ],
        child: BlocListener<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationSuccess) {
              final countryName = state.country;
              SearchController.text = countryName;
              context.read<SearchCountriesCubit>().search(countryName);
            } else if (state is LocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: TextStyle(
                      color: Globals.lightFont,
                      fontSize: Globals.subtitle,
                    ),
                  ),
                  backgroundColor: Globals.secondaryColor,
                ),
              );
            }
          },
          child: BlocBuilder<CountriesCubit, CountriesState>(
            builder: (context, state) {
              if (state is CountriesLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Globals.secondaryColor,
                    strokeWidth: 3,
                  ),
                );
              } else if (state is CountriesError) {
                return Center(child: Text(state.error.toString()));
              } else if (state is CountriesSuccess) {
                final countries = state.countriesResponse.result;
                context.read<SearchCountriesCubit>().setAllCountries(countries);
                return LayoutWithDrawer(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      color: Globals.primaryBackground,
                      child: Column(
                        children: [
                          Search(
                            controller: SearchController,
                            onChanged:
                                (query) => context
                                    .read<SearchCountriesCubit>()
                                    .search(query),
                          ),
                          SizedBox(height: 12),
                          InkWell(
                            onTap: () {
                              context.read<LocationCubit>().getUserLocation();
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Globals.secondaryColor,
                              ),
                              child: BlocBuilder<LocationCubit, LocationState>(
                                builder: (context, locationState) {
                                  if (locationState is LocationLoading) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Globals.lightFont,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Getting location...",
                                          style: TextStyle(
                                            color: Globals.lightFont,
                                            fontSize: Globals.title,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 30,
                                        color: Globals.lightFont,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Get Location",
                                        style: TextStyle(
                                          color: Globals.lightFont,
                                          fontSize: Globals.title,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 12),
                          Expanded(
                            child: BlocBuilder<
                              SearchCountriesCubit,
                              SearchCountriesState
                            >(
                              builder: (context, searchState) {
                                List<Country?> filteredCountries;
                                if (searchState is SearchCountriesFound) {
                                  filteredCountries = searchState.country;
                                } else {
                                  filteredCountries = countries;
                                }
                                return GridView.builder(
                                  itemCount: filteredCountries.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                      ),
                                  itemBuilder: (context, index) {
                                    final country = filteredCountries[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (BuildContext context) =>
                                                    LeaguesScreen(
                                                      countryId:
                                                          country?.countrykey,
                                                    ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Globals.secondaryBackground,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                country?.countrylogo ?? "",
                                                fit: BoxFit.contain,
                                                height: 50,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return Icon(
                                                    Icons.broken_image,
                                                    size: 50,
                                                  );
                                                },
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                country?.countryname ?? "",
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Globals.darkFont,
                                                  fontSize: Globals.title,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(child: Text("Failed to get countries."));
              }
            },
          ),
        ),
      ),
    );
  }
}
