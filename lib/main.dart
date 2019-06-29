import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

Map<String, WidgetBuilder> routes;

void main() => runApp(MyApp());

// 创建应用组件
class MyApp extends StatelessWidget {
  // build 方法用来描述如何构建 UI 界面
  @override
  Widget build(BuildContext context) {
    // 返回一个 Material App 框架（也是一个组件）
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes:{
        'new_page': (context) => NewPage(),
      } ,
      // 应用的首页（依然是一个组件）
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 新的页面：无状态组件
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取路由传参
    print(ModalRoute.of(context).settings.arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text('new Router'),
      ),
      body: Center(
        child: Text('This is new route.'),
      )
    );
  }
}

// 继承自 StatefulWidget （有状态组件）
class MyHomePage extends StatefulWidget {
  // 构造函数
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  // State 类，build 方法也在其中
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 状态
  int _counter = 0;
  // 状态的自增函数
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Material 库中提供的页面脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '你点击 ➕ 的次数:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.title,
            ),
            FlatButton(
              child: Text('open new Router'),
              textColor: Colors.blue,
              onPressed: () {
                // 路由管理的组件，通过栈来管理路由
                // push 打开新页面； pop 关闭页面
                /*
                Navigator.push(
                  context,
                  // 继承自 PageRoute
                  MaterialPageRoute(
                    // 构建路由页面的具体内容，需要一个组件
                    builder: (context) => NewPage(),
                    // settings, // 路由的配置信息
                    // maintainState, // 旧页面信息是否保存在内存中
                    // fullScreenDialog, // 表示新页面是否是一个全屏的对话框
                  ),
                );
                */
                Navigator.pushNamed(context, "new_page", arguments: "hello");
              },
            ),
            RandomWordsWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '点击 +1',
        child: Icon(Icons.add),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}