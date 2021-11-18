import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tourm_app/core/data/remote/tm_api_config.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/core/presentation/customization/no_glow.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/core/presentation/customization/tm_image.dart';
import 'package:tourm_app/core/presentation/states/pm_failure_view.dart';
import 'package:tourm_app/core/presentation/states/pm_loading_view.dart';
import 'package:tourm_app/core/presentation/states/tm_empty_view.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/model/remote/room_remote_model.dart';
import 'package:tourm_app/domain/repository/rooms_repository.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoomsRepository roomsRepository = sl();
    final dummyRooms = <RoomRemoteModel>[
      RoomRemoteModel(
          id: 1,
          title: 'Stanza di Bacco',
          nVisitors: 11,
          imageUrl:
              'http://venetocultura.org/immagini%20schede/Veronese%20Sala_dell%60Olimpo.jpg'),
      RoomRemoteModel(
        id: 2,
        title: 'Stanza dell\'Amore coniugale',
        nVisitors: 5,
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese_Maser%203.jpg',
      ),
      RoomRemoteModel(
        id: 2,
        title: 'Stanza della lucerna',
        nVisitors: 4,
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese_Maser%204.jpg',
      ),
      RoomRemoteModel(
        id: 2,
        title: 'Stanza del cane',
        nVisitors: 1,
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese_Maser%206.jpg',
      ),
      RoomRemoteModel(
          id: 2,
          title: ' Sala a crociera',
          nVisitors: 1,
          imageUrl:
              'http://venetocultura.org/immagini%20schede/Veronese_Maser%201.jpg')
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  'Stanze',
                  style: TextStyle(
                    fontSize: 24,
                    color: TMColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder<Either<Failure, List<RoomRemoteModel>>>(
                future: roomsRepository.getRooms(),
                initialData: Right([]),
                builder: (BuildContext context,
                    AsyncSnapshot<Either<Failure, List<RoomRemoteModel>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.fold(
                      (f) => PMFailureView(failure: f),
                      (rooms) {
                        if (rooms.isEmpty) {
                          return TMEmptyView();
                        }
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            //   child: RoomItem(
                            //     room: dummyRooms[0],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            //   child: RoomItem(
                            //     room: dummyRooms[1],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 160,
                            //   child: HighlightedRooms(rooms: rooms),
                            // ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              shrinkWrap: true,
                              itemCount: dummyRooms.length,
                              itemBuilder: (context, index) {
                                return RoomItem(
                                  room: dummyRooms[index],
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
            ],
          ),
        ),
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  final RoomRemoteModel room;
  const RoomItem({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
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
        margin: EdgeInsets.zero,
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {},
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        // child: TMImage(
                        //   '${getBaseUrl()}/${room.imageUrl}',
                        // ),
                        child: TMImage(
                          room.imageUrl,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            room.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('${room.nVisitors} visitatori'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
            // return Text('s');
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
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  itemCount: roomsList[pageIndex].length,
                  itemBuilder: (context, index) {
                    final item = roomsList[pageIndex][index];
                    //return Text(item.title);
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
