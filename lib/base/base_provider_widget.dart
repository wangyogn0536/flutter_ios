import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Created by 刘冰.
/// Date:2024/3/20
/// des:封装的二层widget的基类，主要页面都会走这里

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T? model; //控件对应的数据
  final Widget? child;

  final Widget Function(BuildContext context, T model, Widget? child)
      builder; //绑定数据的控件
  final Function(T)? onModelInit; //数据初始化方法
  const ProviderWidget(
      {super.key,
      @required this.model,
      required this.builder,
      this.onModelInit,
      this.child});
  @override
  _ProviderWidgetState createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = widget.model!;
      if (widget.onModelInit != null && model != null) {
        widget.onModelInit!(model);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => widget.model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
