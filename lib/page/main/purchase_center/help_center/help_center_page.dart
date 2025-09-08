import '../../../../project_imports.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:帮助中心UI

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('帮助中心', [], isBack: true),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        padding:
            EdgeInsets.only(top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
        color: MyColor.tvDDDColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListContentWidget('1.四叶天静态代理支持哪些系统？',
                  contentText:
                      '静态代理IP是一种长期分配给计算机或网络设备使用的固定IP地址。与动态代理IP不同，静态代理P具有高度的稳定性和可预测性，确保网络连接的持续性和可靠性。它常被用于需要稳定连接和可信赖通信的应用场景。\n支持系统：windows系统，macOS系统（必须是M1芯片以上的），iOS系统，Android系统'),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListContentWidget('2.可以使用代理ip访问国外的站点吗？',
                    contentText:
                        '首先,如果是您本地的网络可以访问的国外站点,咱们的代理ip也是可以使用的\n第二、如果您本地的网络无法访问的站点那咱们代理ip也是访问不了的\n第三、咱们这边暂时没有国外的代理ip, 没有提供相关的服务器'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListContentWidget('3.【静态IP】其他平台可不可以改IP？',
                    contentText:
                        '在此我们只能根据我们的经验和客户使用过的经验，给您提供指导性建议，并不能保证一定可以改变，因为平台太多，每个平台的机制也不一样。\n比如：有的设备IP地址变了之后，过几天平台的IP地址才能变；有的就是根据你最后一次在平台的行为而改变；最省心的还就是设备IP地址变了之后，平台直接改变。'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListContentWidget('4.充值后是否可开具发票？',
                    contentText:
                        '充值后是可以开发票的, 如果您需要开发票的话最好是提前跟客服共同下，\n打对公账户即可打完款后您这边需要及时把付款的截图发给'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListContentWidget('5.为什么我用代理ip站点访问不了',
                    contentText:
                        '针对这个问题您需要看下\n1、您是否访问了国外的站点,如果是访问国外站点的话,咱们的ip可能会出现访问不成功的原因\n2、您需要看下您购买的套餐的实效性,超出了这个ip的实效性的话这个ip就失效了,会导致无法访问站点的问题\n3、如果是使用爬虫的话您需要关注下是否是对方封禁了咱们ip、ua'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListContentWidget('6.使用代理ip了但是本地还是显示我自己的ip',
                    contentText:
                        '对于这部客户首先您可以切换代理ip后访问下 www.ip138.com 看下ip是否是您自己的ip地址'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListContentWidget('7.【静态IP】5、10、20m是什么意思？',
                    contentText:
                        '很多用户以为5m、10m、20m就是指IP能达到这个速度，其实不是的。它是指从5m、10m、20m带宽服务器开出的IP。\nM数字越大网速越好。\n1、如果你只是浏览器页面的话5m的就可以。如果你玩游戏、或者刷视频建议选择10m或者20m\n2、购买前请测试，根据自己的业务选择适合自己的带宽IP。\n3、支持定制，如直播IP，大带宽IP，具体价格请咨询客服。\n4、购买一天的IP，后期包月续费可以低包月费用。\n5、量大有优惠，具体优惠价格请咨询客服。'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ListContentWidget('8.【静态IP】静态 IP 使用场景',
                    contentText:
                        '1、自媒体服务：\n场景描述：在自媒体服务中，有时内容发布者或直播平台可能需要特定的IP地址范围或地理位置来发布内容或进行直播，这可能是因为内容具有地域性、针对特定市场，或者需要确保内容的可访问性和观看体验。\n避免的损失：如果不使用特定的IP地址范围或地理位置限制，自媒体服务可能会误发内容到不相关的地区，导致资源浪费和观众混淆。通过设定IP地址或地理位置限制，可以确保内容准确地推送给目标受众，避免不必要的浪费和误解。\n'
                        '2、游戏行业\n场景描述：在游戏行业中，许多工作室和玩家会使用多个账号进行游戏测试、运营或参与各种活动。然而，一些游戏平台会限制同一IP地址下多个账号的登录，或者对异常登录行为进行监测，从而可能导致账号被封禁。为了避免这种情况，游戏工作室会选择使用代理IP进行多账号管理。\n'
                        '避免的损失：使用代理IP可以为每个账号分配一个独立的IP地址，从而避免同一IP地址下登录多个账号导致的关联检测，减少账号被封禁的风险。\n'
                        '3、远程访问：\n'
                        '场景描述：对于需要远程访问公司内部资源（如文件服务器、数据库等）的员工或合作伙伴，静态IP可以提供一个固定的访问点。\n'
                        '避免的损失：通过静态IP，远程用户可以更容易地记住和访问所需的资源，而无需担心IP地址的变更。使用代理IP可以进一步保护远程访问的安全性，防止未授权访问和数据泄露。\n'
                        '4、网络服务器\n'
                        '场景描述：为了能够让外部用户通过互联网访问服务器，需要为服务器配置一个固定的IP地址。这样可以确保用户在任何时候都能通过该IP地址访问到服务器。\n'
                        '5、模拟测试环境：\n'
                        '场景描述：静态代理IP可以通过选择不同国家地区的代理IP来模拟当地网络环境，用于网站测试等目的。这对于测试网站在不同地区的展示效果或提供不同版本非常有用。\n'
                        '避免的损失：通过模拟不同地区的网络环境，测试人员可以确保网站在不同地理位置的用户面前展示一致，避免因地域差异导致的用户体验问题。如果忽视这一点，可能会导致用户流失和品牌形象受损。\n'
                        '6、网络安全和防火墙：\n'
                        '场景描述：静态IP地址对于网络安全和防火墙规则的设置至关重要，因为它允许管理员精确地控制哪些IP地址可以访问网络资源。\n'
                        '避免的损失：使用静态IP可以减少因IP地址变化而导致的安全漏洞和误报，提高网络安全性。\n'
                        '7、在线游戏\n'
                        '场景描述：一些在线游戏需要稳定的网络连接和较低的延迟，而静态IP可以提供更稳定的网络连接和更低的延迟\n。'
                        '避免的损失：使用静态IP可以提供更好的游戏体验，避免因网络波动或延迟导致的游戏卡顿或掉线。\n'
                        '8、企业视频会议和云端会议\n'
                        '场景描述：在企业视频会议和云端会议中，需要确保参与者的连接稳定且不受干扰。\n'
                        '避免的损失：使用静态IP可以确保会议参与者的连接稳定，避免因IP地址变动导致的连接中断或影响会议质量。\n'
                        '9、网站访问限制的突破\n'
                        '场景描述：使用静态代理IP可以选择不同国家和地区的IP地址，实现跨地区限制访问的目的。\n'
                        '避免的损失：突破地域限制，访问被封锁的网站或服务，提供更广泛的信息访问和娱乐体验。\n'
                        '10、IP白名单和黑名单：\n'
                        '场景描述：某些网站或服务只允许特定的IP地址访问，或者将某些IP地址列入黑名单以阻止访问。\n'
                        '避免的损失：通过配置静态IP或使用代理IP，用户可以将自己的IP地址添加到白名单中，或者绕过黑名单的限制，确保正常访问。'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListContentWidget extends StatefulWidget {
  String titleText;
  String contentText;
  ListContentWidget(this.titleText, {super.key, required this.contentText});

  @override
  State<ListContentWidget> createState() => _ListContentWidgetState();
}

class _ListContentWidgetState extends State<ListContentWidget> {
  bool isContent = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isContent = !isContent;
            });
          },
          child: Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            decoration: myBoxDecoration(backColor: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.titleText,
                  style: MyTextStyle.text15blackStyle,
                ),
                Image.asset(
                  isContent
                      ? 'images/down_arrow_icon.png'
                      : 'images/right_arrow_icon.png',
                  width: 13.w,
                  height: 15.h,
                )
              ],
            ),
          ),
        ),
        isContent
            ? Container(
                padding: EdgeInsets.all(20.w),
                color: MyColor.tvDDDColor,
                // decoration: myBoxDecoration(backColor: MyColor.tvDDDColor),
                child: Text(
                  widget.contentText,
                  style: MyTextStyle.text15blackStyle,
                ),
              )
            : const Center(),
      ],
    );
  }
}
