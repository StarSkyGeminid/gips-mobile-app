// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gips/global/constans.dart';

import '../../model/game_room.dart';

class RankView extends StatelessWidget {
  const RankView({
    Key? key,
    required this.gameRoom,
  }) : super(key: key);

  final GameRoom gameRoom;

  @override
  Widget build(BuildContext context) {
    final orderedList = List.of(gameRoom.connectedClients ?? <GamePlayer>[])
      ..sort(
        (a, b) {
          return b.score?.compareTo(a.score ?? 0) ?? 0;
        },
      );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(kDefaultSpacing * 2),
            padding: const EdgeInsets.all(kDefaultSpacing),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Ranking',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderedList.length,
                    itemBuilder: (context, index) {
                      final player = orderedList[index];
                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: player.username ?? "-"),
                              TextSpan(text: 'Skor : ${player.score ?? 0}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(kDefaultSpacing * .8),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultSpacing),
                        child: Text('Beranda'),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
