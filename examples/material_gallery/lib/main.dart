// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'demo/chip_demo.dart';
import 'demo/date_picker_demo.dart';
import 'demo/drop_down_demo.dart';
import 'demo/modal_bottom_sheet_demo.dart';
import 'demo/page_selector_demo.dart';
import 'demo/persistent_bottom_sheet_demo.dart';
import 'demo/progress_indicator_demo.dart';
import 'demo/toggle_controls_demo.dart';
import 'demo/slider_demo.dart';
import 'demo/tabs_demo.dart';
import 'demo/time_picker_demo.dart';

class GalleryDemo {
  GalleryDemo({ this.title, this.builder });

  final String title;
  final WidgetBuilder builder;
}

class GallerySection extends StatelessComponent {
  GallerySection({ this.colors, this.title, this.demos });

  final Map<int, Color> colors;
  final String title;
  final List<GalleryDemo> demos;

  void showDemo(GalleryDemo demo, BuildContext context, ThemeData theme) {
    Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) {
        Widget child = (demo.builder == null) ? null : demo.builder(context);
        return new Theme(data: theme, child: child);
      }
    ));
  }

  void showDemos(BuildContext context) {
    final theme = new ThemeData(
      brightness: ThemeBrightness.light,
      primarySwatch: colors
    );
    Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) {
        return new Theme(
          data: theme,
          child: new Scaffold(
            toolBar: new ToolBar(center: new Text(title)),
            body: new Material(
              child: new MaterialList(
                type: MaterialListType.oneLine,
                children: (demos ?? <GalleryDemo>[]).map((GalleryDemo demo) {
                  return new ListItem(
                    center: new Text(demo.title, style: theme.text.subhead),
                    onTap: () { showDemo(demo, context, theme); }
                  );
                })
              )
            )
          )
        );
      }
    ));
  }

  Widget build (BuildContext context) {
    final theme = new ThemeData(
      brightness: ThemeBrightness.dark,
      primarySwatch: colors
    );
    return new Theme(
      data: theme,
      child: new Flexible(
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () { showDemos(context); },
          child: new Container(
            height: 256.0,
            margin: const EdgeDims.all(4.0),
            padding: const EdgeDims.only(left: 16.0, bottom: 16.0),
            decoration: new BoxDecoration(backgroundColor: theme.primaryColor),
            child: new Align(
              alignment: const FractionalOffset(0.0, 1.0),
              child: new Text(title, style: theme.text.title)
            )
          )
        )
      )
    );
  }
}

class GalleryHome extends StatelessComponent {

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        bottom: new Container(
          padding: const EdgeDims.only(left: 16.0, bottom: 24.0),
          child: new Align(
            alignment: const FractionalOffset(0.0, 1.0),
            child: new Text('Flutter Gallery', style: Typography.white.headline)
          )
        )
      ),
      body: new Padding(
        padding: const EdgeDims.all(4.0),
        child: new Block(
          <Widget>[
            new Row(
              children: <Widget>[
                new GallerySection(title: 'Animation', colors: Colors.purple),
                new GallerySection(title: 'Style', colors: Colors.green)
              ]
            ),
            new Row(
              children: <Widget>[
                new GallerySection(title: 'Layout', colors: Colors.pink),
                new GallerySection(
                  title: 'Components',
                  colors: Colors.amber,
                  demos: <GalleryDemo>[
                    new GalleryDemo(title: 'Modal Bottom Sheet', builder: (_) => new ModalBottomSheetDemo()),
                    new GalleryDemo(title: 'Persistent Bottom Sheet', builder: (_) => new PersistentBottomSheetDemo()),
                    new GalleryDemo(title: 'Chips', builder: (_) => new ChipDemo()),
                    new GalleryDemo(title: 'Progress Indicators', builder: (_) => new ProgressIndicatorDemo()),
                    new GalleryDemo(title: 'Sliders', builder: (_) => new SliderDemo()),
                    new GalleryDemo(title: 'Toggle Controls', builder: (_) => new ToggleControlsDemo()),
                    new GalleryDemo(title: 'Dropdown Button', builder: (_) => new DropDownDemo()),
                    new GalleryDemo(title: 'Tabs', builder: (_) => new TabsDemo()),
                    new GalleryDemo(title: 'Page Selector', builder: (_) => new PageSelectorDemo()),
                    new GalleryDemo(title: 'Date Picker', builder: (_) => new DatePickerDemo()),
                    new GalleryDemo(title: 'Time Picker', builder: (_) => new TimePickerDemo())
                  ]
                )
              ]
            ),
            new Row(
              children: <Widget>[
                new GallerySection(title: 'Pattern', colors: Colors.cyan),
                new GallerySection(title: 'Usability', colors: Colors.lightGreen)
              ]
            )
          ]
        )
      )
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'Material Gallery',
    routes: {
      '/': (RouteArguments args) => new GalleryHome()
    }
  ));
}
