import 'utils/utils.dart';
import 'utils/manage_mode.dart';

import 'setting/theme_mode_selection_page.dart';

// Settings用の画面
class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isSwitched = true;
  bool _isChecked = true;
  int _selectedRadio = 0;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((value) => setState(() => _themeMode = value));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.lightbulb),
          title: const Text('Dark/Light Mode'),
          trailing: Text((_themeMode == ThemeMode.system)
              ? 'System'
              : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light')),
          onTap: () async {
            var ret =
                await Navigator.of(context).push<ThemeMode>(MaterialPageRoute(
              builder: (context) => ThemeModeSelectionPage(mode: _themeMode),
            ));
            setState(() => _themeMode = ret!);
            await saveThemeMode(_themeMode);
          },
        ),
        SwitchListTile(
          title: const Text('Switch'),
          value: _isSwitched,
          onChanged: (newValue) => {
            setState(() {
              _isSwitched = newValue;
            })
          },
        ),
        CheckboxListTile(
          title: const Text('Checkbox'),
          value: _isChecked,
          onChanged: (newValue) => {
            setState(() {
              _isChecked = newValue!;
            })
          },
        ),
        ListTile(
          title: const Text('Radio'),
          subtitle: Column(
            children: <Widget>[
              RadioListTile(
                title: const Text('Radio 1'),
                value: 1,
                groupValue: _selectedRadio,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRadio = newValue as int;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Radio 2'),
                value: 2,
                groupValue: _selectedRadio,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRadio = newValue as int;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
