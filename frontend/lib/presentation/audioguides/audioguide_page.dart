import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourm_app/core/presentation/states/pm_loading_view.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/datasource/tm_remote_datasource.dart';
import 'package:tourm_app/data/model/remote/article_remote_model.dart';
import 'package:tourm_app/data/model/remote/audioguide_remote_model.dart';

class AudioguidesPage extends StatelessWidget {
  const AudioguidesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TMRemoteDatasource remoteDatasource = sl();
    return Scaffold(
      body: FutureBuilder<List<AudioguideRemoteModel>>(
        future: remoteDatasource.getAudioguides(),
        initialData: null,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<AudioguideRemoteModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            final audioguides = snapshot.data;
            return ListView.builder(
              itemCount: audioguides.length,
              itemBuilder: (context, index) {
                final audioguide = audioguides[index];
                return ListTile(
                  leading: Icon(Icons.headset),
                  title: Text(audioguide.title),
                  onTap: () {},
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
