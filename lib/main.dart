import 'package:chatview_errors/pagination_not_loading.dart';
import 'package:chatview_errors/scroll_controller_error.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatView ScrollController Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ChatView Errors'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text('ScrollController error demo'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScrollControllerError(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Pagination loading demo'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PaginationNotLoading(pageSize: 20),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Pagination not loading demo'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PaginationNotLoading(pageSize: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
