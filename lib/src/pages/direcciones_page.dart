import 'package:flutter/material.dart';
import 'package:sqlite/src/bloc/scans_bloc.dart';
import 'package:sqlite/src/models/scan_model.dart';
import 'package:sqlite/src/utils/utils.dart';

class DireccionesPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getScansByType("http");

    return StreamBuilder(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if( !snapshot.hasData ) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data;

        if( scans.length == 0 ) {
          return Center(
            child: Text("No hay datos"),
          );
        } else {
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) {
              return Dismissible(
                key: UniqueKey(),
                background: Container( color: Colors.red, ),
                onDismissed: (DismissDirection direction) => _onDismiss(scans[i].id),
                child: ListTile(
                  leading: Icon( Icons.cloud_queue ),
                  title: Text( scans[i].valor ),
                  trailing: Icon( Icons.keyboard_arrow_right , color: Theme.of(context).primaryColor ),
                  onTap: () => launchURL(context,scans[i]),
                ),
              );
            }
          );
        }

      },
    );
  }

  _onDismiss (id) {
    scansBloc.deleteScan(id);
  }
}