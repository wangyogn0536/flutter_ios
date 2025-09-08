import '../../../../data/product_node_list_entity.dart';
import '../../../../data/static_node_list_entity.dart';
import '../../../../project_imports.dart';
import 'city_select_node_page_model.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:城市节点选择UI
class CitySelectNodePage extends StatefulWidget {
  String daikuan;
  bool isProduct;
  bool isProductType;
  bool isProductBuyType;
  CitySelectNodePage(
      this.daikuan, this.isProduct, this.isProductType, this.isProductBuyType,
      {super.key});

  @override
  State<CitySelectNodePage> createState() => _CitySelectNodePageState();
}

class _CitySelectNodePageState
    extends BaseState<CitySelectNodePageModel, CitySelectNodePage> {
  int selectIndex = 0;
  @override
  Widget getContentChild(CitySelectNodePageModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      appBar: const CustomAppBar('城市节点选择', [], isBack: true),
      body: Container(
          color: MyColor.tvDDDColor,
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Row(
            children: [
              Container(
                width: 130.w,
                margin: EdgeInsets.only(bottom: 1.w),
                color: Colors.white,
                child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                        if (widget.isProduct) {
                          model.productNodeChilderList.clear();
                          model.productNodeChilderList
                              .addAll(model.productNodeList[index].childer);
                        } else {
                          model.nodeChilderList.clear();
                          model.nodeChilderList
                              .addAll(model.nodeList[index].childer);
                        }
                      });
                    },
                    child: Container(
                      height: 50.h,
                      margin: EdgeInsets.only(right: 2.w),
                      decoration: myBoxDecoration(
                          backColor: selectIndex == index
                              ? MyColor.themeColor
                              : Colors.white),
                      child: Center(
                        child: Text(
                          widget.isProduct
                              ? model.productNodeList[index].name
                              : model.nodeList[index].name,
                          style: selectIndex == index
                              ? MyTextStyle.text17whiteStyle
                              : TextStyle(
                                  fontSize: 17.sp, color: MyColor.gray333Color),
                        ),
                      ),
                    ),
                  ),
                  itemCount: widget.isProduct
                      ? model.productNodeList.length
                      : model.nodeList.length,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: ListView.builder(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (widget.isProduct) {
                          Navigator.pop(
                              context,
                              ProductCustomParams(
                                  model.productNodeList[selectIndex],
                                  model.productNodeChilderList[index]));
                        } else {
                          Navigator.pop(
                              context,
                              StaticCustomParams(model.nodeList[selectIndex],
                                  model.nodeChilderList[index]));
                        }
                        // Navigator.pop(
                        //     context,
                        // CustomParams(model.nodeList[selectIndex],
                        //     model.cityNodeList[index]));
                      },
                      child: Container(
                        height: 50.h,
                        decoration: myBoxDecoration(backColor: Colors.white),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.isProduct
                                    ? model.productNodeChilderList[index].name
                                    : model.nodeChilderList[index].name,
                                style: MyTextStyle.text15blackStyle,
                              ),

                              ///
                              Text(
                                widget.isProduct
                                    ? widget.isProductBuyType
                                        ? '剩余：${model.productNodeChilderList[index].lt}'
                                        : '剩余：${model.productNodeChilderList[index].dx}'
                                    : '剩余：${model.nodeChilderList[index].num}',
                                style: MyTextStyle.text15themeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: widget.isProduct
                        ? model.productNodeChilderList.length
                        : model.nodeChilderList.length,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  // TODO: implement viewModel
  CitySelectNodePageModel get viewModel => CitySelectNodePageModel(
      widget.daikuan,
      widget.isProduct,
      widget.isProductType,
      widget.isProductBuyType);
}

///静态ip返回传递参数
class StaticCustomParams {
  final StaticNodeListDataNode staticNodeListDataNode;
  final StaticNodeListDataNodeChilder staticNodeListDataNodeChilder;
  StaticCustomParams(
      this.staticNodeListDataNode, this.staticNodeListDataNodeChilder);
}

///住宅ip返回传递参数
class ProductCustomParams {
  final ProductNodeListDataNode productNodeListDataNode;
  final ProductNodeListDataNodeChilder productNodeListDataNodeChilder;
  ProductCustomParams(
      this.productNodeListDataNode, this.productNodeListDataNodeChilder);
}

// ///返回传递两个参数
// class CustomParams {
//   final ProductProvinceListBeanDataAreas provinces;
//   final CityNodeBeanData cityNode;
//   CustomParams(this.provinces, this.cityNode);
// }
