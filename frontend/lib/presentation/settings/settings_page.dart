import 'package:flutter/material.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/core/presentation/states/pm_failure_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 24,
                    color: TMColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text('Informations about the app'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AboutDialog(
                        applicationIcon: Icon(Icons.museum_rounded),
                        applicationVersion: '0.0.1',
                        children: [
                          Text("All rights reserved"),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: Text('Credits'),
                subtitle: Text('Who made the app'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return CreditsView();
                    }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreditsView extends StatelessWidget {
  const CreditsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: FutureBuilder(
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Text(
              snapshot.data.body,
            );
          } else if (snapshot.hasError) {
            return PMFailureView(
              failure: snapshot.error,
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
