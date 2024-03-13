import '../utils/utils.dart';

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({Key? key, required this.mode}) : super(key: key);
  final ThemeMode mode;

  @override
  _ThemeModeSelectionPageState createState() => _ThemeModeSelectionPageState();
}

class _ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  late ThemeMode _currentThemeMode;
  @override
  void initState() {
    super.initState();
    _currentThemeMode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop<ThemeMode>(context, _currentThemeMode),
              ),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _currentThemeMode,
              title: const Text('System'),
              onChanged: (newValue) {
                setState(() {
                  _currentThemeMode = newValue!;
                });
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _currentThemeMode,
              title: const Text('Light'),
              onChanged: (newValue) {
                setState(() {
                  _currentThemeMode = newValue!;
                });
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _currentThemeMode,
              title: const Text('Dark'),
              onChanged: (newValue) {
                setState(() {
                  _currentThemeMode = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}