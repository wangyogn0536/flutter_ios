import 'package:flutter/material.dart';

import 'base_provider_widget.dart';
import 'base_view_model.dart';
import 'loading_state_widget.dart';

/// Created by 刘冰.
/// Date:2024/3/20
/// des:widget一层基类
abstract class BaseState<M extends BaseViewModel, T extends StatefulWidget>
    extends State<T> with AutomaticKeepAliveClientMixin {
  M get viewModel; //真实获取数据的仓库

  bool isListData = false;

  Widget getContentChild(M model);

  void init() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    init();
    return ProviderWidget<M>(
      model: viewModel,
      onModelInit: (model) => {model.firstLoadData()},
      builder: (context, model, child) {
        return LoadingStateWidget(
          isListData: isListData,
          viewState: model.viewState,
          child: getContentChild(model),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
