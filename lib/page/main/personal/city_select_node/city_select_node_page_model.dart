import 'package:agent_app_vpn/project_imports.dart';

import '../../../../data/product_node_list_entity.dart';
import '../../../../data/static_node_list_entity.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:城市节点选择VM

class CitySelectNodePageModel extends BaseViewModel {
  String daikuan;

  bool isProduct;
  bool isProductType;
  bool isProductBuyType;
  CitySelectNodePageModel(
      this.daikuan, this.isProduct, this.isProductType, this.isProductBuyType);
  /** 静态列表数据*/
  ///省份列表
  List<StaticNodeListDataNode> nodeList = [];

  ///节点列表
  List<StaticNodeListDataNodeChilder> nodeChilderList = [];
  /** 住宅数据  */
  ///省份列表
  List<ProductNodeListDataNode> productNodeList = [];

  ///节点列表
  List<ProductNodeListDataNodeChilder> productNodeChilderList = [];
  @override
  void firstLoadData() {
    // TODO: implement firstLoadData
    super.firstLoadData();
    if (isProduct) {
      residenceNodeAPI(isProductBuyType ? '3' : '1', isProductType ? '2' : '1');
    } else {
      cityNodeAPI(daikuan);
    }
  }

  ///静态节点列表
  void cityNodeAPI(String daikuan) {
    HttpManager.requestData(
        Url.productCity, true, {'type': daikuan}, ConfigString.requestPost,
        success: (res) {
      nodeList.clear();
      nodeChilderList.clear();
      StaticNodeListEntity staticNodeListEntity =
          StaticNodeListEntity.fromJson(res);
      nodeList.addAll(staticNodeListEntity.data.node);
      nodeChilderList.addAll(nodeList[0].childer);
    }, complete: () {
      notifyListeners();
    });
  }

  ///住宅节点列表
  void residenceNodeAPI(String type, String buyType) {
    HttpManager.requestData(
        Url.residenceNode,
        true,
        {'type': type, 'buy_type': buyType},
        ConfigString.requestPost, success: (res) {
      productNodeList.clear();
      productNodeChilderList.clear();
      ProductNodeListEntity productNodeListEntity =
          ProductNodeListEntity.fromJson(res);
      productNodeList.addAll(productNodeListEntity.data.node);
      productNodeChilderList.addAll(productNodeList[0].childer);
    }, complete: () {
      notifyListeners();
    });
  }
}
