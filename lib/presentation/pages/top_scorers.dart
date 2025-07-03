import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportable/Services/cubits/topscorers_cubit.dart/topscorers_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';

class TopScorers extends StatelessWidget {
  const TopScorers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopscorersCubit, TopscorersState>(
      builder: (context, state) {
        if (state is TopscorersLoading) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Globals.secondaryColor,
              strokeWidth: 3,
            ),
          );
        } else if (state is TopscorersError) {
          return Center(child: Text(state.error.toString()));
        } else if (state is TopscorersSuccess) {
          return ListView.builder(
            itemCount: state.topscorersResponse.result.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final topscorer = state.topscorersResponse.result[index];
              return Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Globals.secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: Globals.secondaryColor,
                        fontSize: Globals.title,
                      ),
                    ),
                    SizedBox(width: 24),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topscorer?.playerName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Globals.secondaryColor,
                            fontSize: Globals.title,
                          ),
                        ),
                        Text(
                          topscorer?.teamName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          'Goals: ${topscorer?.goals ?? "0"}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          'Assists: ${topscorer?.assists ?? "0"}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(child: Text("Failed to get Topscorers data"));
        }
      },
    );
  }
}
