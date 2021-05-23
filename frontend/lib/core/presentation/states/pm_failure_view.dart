import 'package:flutter/material.dart';

import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/core/infrastructure/localization/app_localizations.dart';
import 'package:tourm_app/core/infrastructure/report/report_manager.dart';

class PMFailureView extends StatelessWidget {
  final Failure failure;
  final Function refresh;

  const PMFailureView({
    Key key,
    @required this.failure,
    this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Icon(
              Icons.error,
              size: 80,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              failure.localizedDescription(context),
              textAlign: TextAlign.center,
            ),
          ),
          if (refresh != null)
            const SizedBox(
              height: 12,
            ),
          TextButton(
            child: Text(
              'Mostra errore',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(failure.localizedDescription(context)),
                    content: SelectableText(failure.e.toString()),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                      TextButton(
                        onPressed: () async {
                          TMReportManager.sendEmail(
                            context,
                            failure: failure,
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('bug_report_alert'),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          if (refresh != null)
            TextButton(
              child: Text(
                AppLocalizations.of(context).translate('refresh'),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              onPressed: refresh,
            )
        ],
      ),
    );
  }
}
