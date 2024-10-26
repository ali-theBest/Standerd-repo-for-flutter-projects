import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'custom_check_internet.dart';

class ConnectivityWidget extends StatefulWidget {
  final Widget onlineChild;
  final Widget offlineChild;


  ConnectivityWidget({required this.onlineChild, required this.offlineChild});

  @override
  _ConnectivityWidgetState createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  final ConnectivityService _connectivityService = GetIt.instance<ConnectivityService>();
  late Stream<ConnectivityStatus> _connectivityStream;
  ConnectivityStatus _connectionStatus = ConnectivityStatus.Online;

  @override
  void initState() {
    super.initState();
    _connectivityStream = _connectivityService.connectivityStream;
    _connectivityStream.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == ConnectivityStatus.Online
        ? widget.onlineChild
        : widget.offlineChild;
  }
}
