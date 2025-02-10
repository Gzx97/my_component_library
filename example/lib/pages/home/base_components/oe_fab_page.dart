import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeFabPage extends StatelessWidget {
  const OeFabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fab Example'),
      ),
      body: Center(
        child: Column(
          children: const [
            OeFab(
              theme: OeFabTheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
