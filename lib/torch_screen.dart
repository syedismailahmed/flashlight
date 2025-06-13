import 'dart:async';
import 'package:flashlight_app/image_assets/images.dart';
import 'package:flutter/material.dart';
import 'package:torch_flashlight/torch_flashlight.dart';
class TorchScreen extends StatefulWidget {
  const TorchScreen({super.key});
  @override
  _TorchScreenState createState() => _TorchScreenState();
}
class _TorchScreenState extends State<TorchScreen> {
  bool isTorchOn = false;
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder<bool>(
            future: _isTorchAvailable(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (snapshot.hasData && snapshot.data!) {
                return Center(
                  child: InkWell(
                    onLongPress: _toggleTorch,
                    child: Column(
                      children:[
                      isTorchOn
                        ?Image.asset(lightOff,height: 775,)
                          :Image.asset(lightOn,height: 775,)
                      ]
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('No torch available.'));
              }
            },
          ),
        ],
      ),
    );
  }
  Future<bool> _isTorchAvailable() async {
    try {
      return await TorchFlashlight.isTorchFlashlightAvailable();
    } catch (e) {
      _showMessage('Could not check if the device has an available torch');
      return false;
    }
  }
  Future<void> _toggleTorch() async {
    if (isTorchOn) {
      await _disableTorch();
    } else {
      await _enableTorch();
    }
  }
  Future<void> _enableTorch() async {
    try {
      await TorchFlashlight.enableTorchFlashlight();
      setState(() {
        isTorchOn = true;
      });
    } catch (e) {
      _showMessage('Could not enable torch');
    }
  }
  Future<void> _disableTorch() async {
    try {
      await TorchFlashlight.disableTorchFlashlight();
      setState(() {
        isTorchOn = false;
      });
    } catch (e) {
      _showMessage('Could not disable torch');
    }
  }
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}