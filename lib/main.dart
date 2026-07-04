import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mes Liens',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const LinkListScreen(),
    );
  }
}

class LinkListScreen extends StatefulWidget {
  const LinkListScreen({super.key});

  @override
  State<LinkListScreen> createState() => _LinkListScreenState();
}

class _LinkListScreenState extends State<LinkListScreen> {
  List<dynamic> _links = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadLinks();
  }

  // Fonction pour charger et décoder le fichier JSON
  Future<void> _loadLinks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final file = File('/storage/emulated/0/AppsPerso/my_urls/liens.json');

      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _links = jsonDecode(content);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Fichier "liens.json" introuvable dans AppsPerso/my_urls.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors de la lecture du fichier : $e';
        _isLoading = false;
      });
    }
  }

  // Fonction pour ouvrir l'URL dans le navigateur par défaut
  Future<void> _openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible d\'ouvrir le lien : $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Liens Personnels'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadLinks),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            )
          : _links.isEmpty
          ? const Center(child: Text('Aucun lien trouvé dans le fichier.'))
          : ListView(
              physics:
                  const AlwaysScrollableScrollPhysics(), // Force le comportement de défilement Android
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Nom',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Infos',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: _links.map((link) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              link['nom'] ?? '',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () => _openUrl(link['url'] ?? ''),
                          ),
                          DataCell(Text(link['infos'] ?? '')),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
