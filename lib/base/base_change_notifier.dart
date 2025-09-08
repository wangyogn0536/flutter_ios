import '../project_imports.dart';
import 'loading_state_widget.dart';

/// Created by 刘冰.
/// Date:2024/3/20
/// des:基类观察者

class BaseChangeNotifier with ChangeNotifier {
  ViewState viewState = ViewState.done;

  bool _dispose = false;

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }
}
