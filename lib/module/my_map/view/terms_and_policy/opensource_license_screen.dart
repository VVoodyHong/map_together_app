import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/oss_licenses.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OpensourceLicenseScreen extends StatelessWidget {
  static Future<List<Package>> loadLicenses() async {
    final lm = <String, List<String>>{};
    await for (var l in LicenseRegistry.licenses) {
      for (var p in l.packages) {
        final lp = lm.putIfAbsent(p, () => []);
        lp.addAll(l.paragraphs.map((p) => p.text));
      }
    }
    final licenses = ossLicenses.toList();
    for (var key in lm.keys) {
      licenses.add(
        Package(
          name: key,
          description: '',
          authors: [],
          version: '',
          license: lm[key]!.join('\n\n'),
          isMarkdown: false,
          isSdk: false,
          isDirectDependency: false,
        )
      );
    }
    return licenses..sort((a, b) => a.name.compareTo(b.name));
  }

  static final _licenses = loadLicenses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '오픈소스 라이선스',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        ),
      ).init(),
      body: FutureBuilder<List<Package>>(
        future: _licenses,
        initialData: [],
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Package package = snapshot.data![index];
              return ListTile(
                title: Text('${package.name} ${package.version}'),
                subtitle: package.description.isNotEmpty ? Text(package.description) : null,
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MiscOssLicenseSingle(package: package),
                  ),
                ),
              );
            },
          );
        }
      )
    );
  }
}

class MiscOssLicenseSingle extends StatelessWidget {
  final Package package;

  MiscOssLicenseSingle({required this.package});

  String _bodyText() {
    return package.license!.split('\n').map((line) {
      if (line.startsWith('//')) line = line.substring(2);
      line = line.trim();
      return line;
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '${package.name} ${package.version}',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.back(),
        ),
      ).init(),
      body: Container(
        color: Theme.of(context).canvasColor,
        child: ListView(
          children: <Widget>[
            if (package.description.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: Text(
                  package.description,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)
                )
              ),
            if (package.homepage != null)
              Padding(
                padding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: InkWell(
                  child: Text(
                    package.homepage!,
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)
                  ),
                  onTap: () => launchUrl(Uri.parse(package.homepage!)),
                )
              ),
            if (package.description.isNotEmpty || package.homepage != null) Divider(),
            Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Text(
                _bodyText(),
                style: Theme.of(context).textTheme.bodyText2
              ),
            ),
          ]
        )
      ),
    );
  }
}