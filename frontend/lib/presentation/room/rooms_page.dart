import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/core/presentation/customization/no_glow.dart';
import 'package:tourm_app/core/presentation/states/pm_failure_view.dart';
import 'package:tourm_app/core/presentation/states/pm_loading_view.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/model/remote/room_remote_model.dart';
import 'package:tourm_app/domain/repository/rooms_repository.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoomsRepository roomsRepository = sl();
    return Scaffold(
      body: FutureBuilder<Either<Failure, List<RoomRemoteModel>>>(
        future: roomsRepository.getRooms(),
        initialData: Right([]),
        builder: (BuildContext context,
            AsyncSnapshot<Either<Failure, List<RoomRemoteModel>>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.fold(
              (f) => PMFailureView(failure: f),
              (rooms) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    RoomItem(
                      room: rooms[0],
                    ),
                    RoomItem(
                      room: rooms[1],
                    ),
                    SizedBox(
                      height: 200,
                      child: HighlightedRooms(rooms: rooms),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return RoomItem(
                          room: rooms[index],
                        );
                      },
                    )
                  ],
                );
              },
            );
          } else {
            return TMLoadingView();
          }
        },
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  final RoomRemoteModel room;
  const RoomItem({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(room.title),
      ),
    );
  }
}

class HighlightedRooms extends StatelessWidget {
  final List<RoomRemoteModel> rooms;

  const HighlightedRooms({
    Key key,
    @required this.rooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pages = rooms.length ~/ 2;

    final remainder = rooms.length % 2;

    if (remainder > 0 && remainder <= 2) {
      pages += 1;
    } else if (remainder >= 2) {
      pages += 2;
    }

    List<List<RoomRemoteModel>> roomsList = [];
    List roomsCopy = rooms.map((element) => element).toList();

    for (int i = 0; i < pages; i++) {
      if (roomsCopy.length >= 2) {
        roomsList.add(roomsCopy.take(2).toList());
        roomsCopy.removeRange(0, 2);
      } else if (roomsCopy.length == 1) {
        roomsList.add(roomsCopy.take(1).toList());
        roomsCopy.removeRange(0, 1);
      }
    }

    return Padding(
      padding: pages == 1 ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
      child: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: PageView.builder(
          pageSnapping: true,
          controller: PageController(
            viewportFraction: pages == 1 ? 1.0 : 0.5,
            initialPage: 1,
          ),
          itemCount: pages,
          itemBuilder: (context, pageIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // padding: EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: roomsList[pageIndex].length,
                  itemBuilder: (context, index) {
                    final item = roomsList[pageIndex][index];
                    return ListTile(
                      title: Text(item.title),
                      // subtitle: Text(
                      //     'Aula ${item.number}${item.floor >= 1 ? ' - ${item.floor} piano' : ''}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              // return RoomPage(
                              //   roomId: item.id,
                              //   name: item.title,
                              // );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
