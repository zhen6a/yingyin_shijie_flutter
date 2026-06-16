import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const YingyinApp());
}

class YingyinApp extends StatelessWidget {
  const YingyinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '影音视界',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFD8B46A),
        scaffoldBackgroundColor: const Color(0xFF101114),
        fontFamily: 'PingFang SC',
      ),
      home: const ShellPage(),
    );
  }
}

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;
  String apiUrl = 'http://www.饭太硬.cc/tv';
  int sourceColumns = 2;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(apiUrl: apiUrl),
      SearchPage(apiUrl: apiUrl),
      SourcePage(
        columns: sourceColumns,
        onChanged: (value) => setState(() => sourceColumns = value),
      ),
      SettingsPage(
        apiUrl: apiUrl,
        onApiChanged: (value) => setState(() => apiUrl = value),
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.movie_outlined), label: '首页'),
          NavigationDestination(icon: Icon(Icons.search), label: '搜索'),
          NavigationDestination(icon: Icon(Icons.swap_horiz), label: '换源'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: '设置'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.apiUrl});

  final String apiUrl;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      18,
      (index) => MovieItem(
        title: ['庆余年', '繁花', '狂飙', '三体', '长安十二时辰', '莲花楼'][index % 6],
        tag: ['更新至 12', '高清', '蓝光', '热播'][index % 4],
      ),
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '影音视界',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '官网𝒐𝒌𝒇𝒎.𝒄𝒏',
                            style: TextStyle(color: Color(0xFFD8B46A), fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            apiUrl,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white.withOpacity(0.52), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.live_tv, size: 42, color: Color(0xFFD8B46A)),
                  ],
                ),
                const SizedBox(height: 20),
                const _HeroCard(),
                const SizedBox(height: 18),
                const Text(
                  '推荐影片',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
          sliver: SliverGrid.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, index) => MovieCard(item: items[index]),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF2B2213), Color(0xFF725A28), Color(0xFF14161B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('跨平台影视壳', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            SizedBox(height: 8),
            Text('Flutter 版，可扩展 iOS IPA 与 Android APK'),
          ],
        ),
      ),
    );
  }
}

class MovieItem {
  const MovieItem({required this.title, required this.tag});
  final String title;
  final String tag;
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.item});

  final MovieItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => DetailPage(item: item)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF30343B), Color(0xFF17191E)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(Icons.movie, size: 48, color: Colors.white24),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(item.tag, style: const TextStyle(fontSize: 10)),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.58)),
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.item});

  final MovieItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1B1D22),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.play_circle_fill, size: 72, color: Color(0xFFD8B46A)),
            ),
            const SizedBox(height: 18),
            Text(item.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              '这里预留真实播放、选集、简介和换源能力。接入接口解析后可播放 m3u8 / mp4。',
              style: TextStyle(color: Colors.white.withOpacity(0.68), height: 1.5),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text('立即播放'),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.apiUrl});

  final String apiUrl;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('搜索', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '输入影片名称',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '当前接口：${widget.apiUrl}',
            style: TextStyle(color: Colors.white.withOpacity(0.58), fontSize: 12),
          ),
          const Spacer(),
          Center(
            child: Text(
              '搜索接口接入后将在这里显示结果',
              style: TextStyle(color: Colors.white.withOpacity(0.45)),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class SourcePage extends StatelessWidget {
  const SourcePage({super.key, required this.columns, required this.onChanged});

  final int columns;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final sources = List.generate(24, (index) => '线路 ${index + 1}');

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('换源', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 2, label: Text('2 列')),
              ButtonSegment(value: 3, label: Text('3 列')),
              ButtonSegment(value: 4, label: Text('4 列')),
            ],
            selected: {columns},
            onSelectionChanged: (value) => onChanged(value.first),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: sources.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: columns == 4 ? 2.3 : 2.8,
              ),
              itemBuilder: (_, index) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1D22),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: index == 0 ? const Color(0xFFD8B46A) : Colors.white12),
                ),
                child: Text(
                  sources[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.apiUrl, required this.onApiChanged});

  final String apiUrl;
  final ValueChanged<String> onApiChanged;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.apiUrl);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('设置', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('影音视界', style: TextStyle(color: Color(0xFFD8B46A), fontSize: 13)),
        const SizedBox(height: 2),
        const Text('官网𝒐𝒌𝒇𝒎.𝒄𝒏', style: TextStyle(color: Color(0xFFD8B46A), fontSize: 13)),
        const SizedBox(height: 18),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: '接口地址',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          ),
          onSubmitted: widget.onApiChanged,
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () => widget.onApiChanged(controller.text.trim()),
          child: const Text('保存接口'),
        ),
        const SizedBox(height: 18),
        const _SettingTile(title: '版本', subtitle: '3.6.9+369'),
        const _SettingTile(title: '官网', subtitle: '𝒐𝒌𝒇𝒎.𝒄𝒏'),
        const _SettingTile(title: 'iOS 打包', subtitle: '需要 macOS、Xcode、Apple 开发者证书'),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1D22),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.58), fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
