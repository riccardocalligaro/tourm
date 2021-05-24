import 'package:flutter/material.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/core/presentation/states/pm_loading_view.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/datasource/tm_remote_datasource.dart';
import 'package:tourm_app/data/model/remote/audioguides_with_room.dart';
import 'package:tourm_app/presentation/audioguides/audioguide_page.dart';

class AudioguidesPage extends StatelessWidget {
  const AudioguidesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TMRemoteDatasource remoteDatasource = sl();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  'Audioguides',
                  style: TextStyle(
                    fontSize: 24,
                    color: TMColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder<List<AudioguideWithRoomRemoteModel>>(
                future: remoteDatasource.getAudioguidesWithRooms(),
                initialData: null,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<AudioguideWithRoomRemoteModel>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final audioguides = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: audioguides.length,
                      itemBuilder: (context, index) {
                        final audioguide = audioguides[index];
                        return ListTile(
                          leading: Icon(Icons.headset),
                          title: Text(audioguide.title),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AudioguidePage(
                                  audioguideWithRoom: audioguide,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return TMLoadingView();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
