import 'package:flutter/material.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/core/presentation/states/pm_loading_view.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/datasource/tm_remote_datasource.dart';
import 'package:tourm_app/data/model/remote/audioguide_remote_model.dart';
import 'package:tourm_app/data/model/remote/audioguides_with_room.dart';
import 'package:tourm_app/presentation/audioguides/audioguide_page.dart';

class AudioguidesPage extends StatelessWidget {
  const AudioguidesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dummyAudioguides = <AudioguideWithRoomRemoteModel>[
      AudioguideWithRoomRemoteModel(
        id: 1,
        title: 'Stanza di Bacco',
        path:
            'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese%20Sala_dell%60Olimpo.jpg',
      ),
      AudioguideWithRoomRemoteModel(
        id: 1,
        title: 'Stanza dell\'Amore coniugale',
        path:
            'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese_Maser%203.jpg',
      ),
      AudioguideWithRoomRemoteModel(
        id: 1,
        title: 'Stanza della lucerna',
        path:
            'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese_Maser%204.jpg',
      ),
      AudioguideWithRoomRemoteModel(
        id: 1,
        title: 'Stanza del cane',
        path:
            'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese_Maser%206.jpg',
      ),
      AudioguideWithRoomRemoteModel(
        id: 1,
        title: ' Sala a crociera',
        path:
            'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3',
        imageUrl:
            'http://venetocultura.org/immagini%20schede/Veronese_Maser%206.jpg',
      ),
    ];
    final TMRemoteDatasource remoteDatasource = sl();
    return Scaffold(
      // appBar: AppBar(
      //   brightness: Brightness.dark,
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  'Audioguide',
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
                      itemCount: dummyAudioguides.length,
                      itemBuilder: (context, index) {
                        final audioguide = dummyAudioguides[index];
                        return ListTile(
                          leading: Icon(Icons.headset),
                          title: Text(audioguide.title),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AudioguidePage(
                                  audioguides: [audioguide],
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
