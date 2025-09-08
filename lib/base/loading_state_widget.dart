import 'package:agent_app_vpn/project_imports.dart';

enum ViewState { loading, done, error }

/// Created by 刘冰.
/// Date:2024/3/20
/// des:加载数据页面封装
class LoadingStateWidget extends StatelessWidget {
  ///是否是列表页面
  final bool? isListData;
  final ViewState? viewState;
  final VoidCallback? retry;
  final Widget? child;
  const LoadingStateWidget({
    super.key,
    this.viewState,
    this.retry,
    this.child,
    this.isListData,
  });

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      if (isListData!) {
        return _loadView;
      } else {
        return child!;
      }
    } else if (viewState == ViewState.error) {
      if (isListData!) {
        Navigator.pop(context);
      }
      return _errorView;
    } else {
      return child!;
    }
  }

  Widget get _errorView {
    return Center(
      // 类似LinearLayout
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image.asset(
          //   'images/ic_error.png',
          //   width: 100,
          //   height: 100,
          // ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              ConfigString.netRequestFail,
              style: TextStyle(color: MyColor.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: retry,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
              child: const Text(
                ConfigString.reLoadAgain,
                style: TextStyle(color: Colors.black87),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get _loadView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
