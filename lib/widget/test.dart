import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:valu/bloc/home_sections/home_sections.dart';
import 'package:valu/constants/colors.dart';
import 'package:valu/constants/font_sizes.dart';
import 'package:valu/repositories/valu_repository.dart';
import 'package:valu/widgets/Custom/helper_dialogs.dart';
import 'package:valu/widgets/Custom/search_widget.dart';
import 'package:valu/widgets/Custom/vendor_card.dart';
import 'package:valu/models/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:valu/widgets/login/landing-page.dart';
import 'package:valu/widgets/navigation/valu_app_bar_widget.dart';
import 'package:valu/widgets/stores/stores-page.dart';

class HomeSectionsTab extends StatefulWidget {
  final ValuRepository valuRepository;

  HomeSectionsTab({Key key, @required this.valuRepository})
      : assert(valuRepository != null),
        super(key: key);

  @override
  State<HomeSectionsTab> createState() => _HomeSectionsTabState();
}

class _HomeSectionsTabState extends State<HomeSectionsTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Completer<void> _refreshCompleter;
  AnimationController _controller;
  Animation<Offset> _headerOffsetFloat;
  Animation<Offset> _offsetFloat;
  HomeSectionsBloc _homeSectionsBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _headerOffsetFloat =
        Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
            .animate(_controller);
    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 5.0), end: Offset.zero)
        .animate(_controller);

    _homeSectionsBloc = HomeSectionsBloc(valuRepository: widget.valuRepository);
    _homeSectionsBloc
        .dispatch(FetchHomeSectionsEvent(screenType: ScreenType.ANONYMOUS));
  }

  @override
  void dispose() {
    _controller.dispose();
    _homeSectionsBloc.dispose();
    super.dispose();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<HomeSection> homeSectionList;
  List<Branch> branchList;
  @override
  Widget build(BuildContext context) {
    super.build(context); // need to call super method.
    return BlocListener(
      bloc: _homeSectionsBloc,
      listener: (BuildContext context, HomeSectionsState state) {
        if (state is HomeSectionsLoadingState ||
            state is InitialHomeSectionsState) {
          setIsLoading(true);
        } else if (state is HomeSectionsLoadedState) {
          setIsLoading(false);
          setState(() {
            homeSectionList = state.homeSectionList;

            _refreshCompleter?.complete();
            _refreshCompleter = Completer();

            _controller.forward();
          });
        } else if (state is VendorBranchesLoadedState) {
          setIsLoading(false);
          setState(() {
            branchList = state.branchList;
            showBranchesSheet(context);
          });
        } else if (state is HomeSectionsErrorState) {
          setIsLoading(false);
          showErrorDialog(state.errorMsg);
        }
      },
      child: BlocBuilder(
        bloc: _homeSectionsBloc,
        builder: (BuildContext context, HomeSectionsState state) {
          return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () {
                _homeSectionsBloc.dispatch(RefreshHomeSectionsEvent(
                    screenType: ScreenType.APPLIED_WITHOUT_LIMIT));
                return _refreshCompleter.future;
              },
              child: ListView.builder(
                  itemCount: (state == null || homeSectionList == null)
                      ? 1
                      : homeSectionList.length + 1,
                  itemBuilder: _buildSection));
        },
      ),
    );
  }

  void setIsLoading(bool val) {
    LoadingDialog.setIsLoading(context, val);
  }

  void showErrorDialog(String errMsg) {
    Dialogs.showErrorDialog(context, errMsg);
  }

  Widget getHeaderWidget() {
    return Column(
      children: <Widget>[
        SlideTransition(
          position: _headerOffsetFloat,
          child: Container(
            height: 100,
            margin: EdgeInsets.all(20),
            child: OutlineButton(
              borderSide: BorderSide(color: Colorspalette.valuAccentColor),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                Navigator.pushNamed(context, LandingPage.routeName);
              },
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "resources/icons/ic_mobile_orange.png",
                    width: 40,
                    height: 40,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                          child: Text(
                              FlutterI18n.translate(
                                  context, "register_login_to_valu"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: FontSizes.medium)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                          child: Text(
                              FlutterI18n.translate(
                                  context, "apply_to_valu_message"),
                              style: TextStyle(
                                  color: Colorspalette.subTitleColor,
                                  fontSize: FontSizes.small)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Image.asset(
                      "resources/icons/ic_arrow_right.png",
                      width: 30,
                      height: 30,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SlideTransition(
          position: _offsetFloat,
          child: Container(
              //height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Stack(
                children: <Widget>[
                  SearchWidget(
                      placeHolder:
                          FlutterI18n.translate(context, "try_playstation"),
                      onChanged: (value) {}),
                  FlatButton(
                    onPressed: () {
                      goToStoresPage();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }

  Widget _buildSection(BuildContext context, int index) {
    if (homeSectionList == null || homeSectionList.length == 0) return null;
    if (index == 0)
      return getHeaderWidget();
    else
      index -= 1;
    return (homeSectionList == null ||
            homeSectionList.length < index ||
            homeSectionList[index].vendors == null ||
            homeSectionList[index].vendors.length == 0)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SlideTransition(
                  position: _offsetFloat,
                  child: _buildSectionHeader(homeSectionList[index].title,
                      homeSectionList[index].description)),
              SlideTransition(
                  position: _offsetFloat,
                  child: _buildSectionDetails(homeSectionList[index].vendors))
            ],
          );
  }

  Widget _buildSectionHeader(String title, String description) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  title,
                  style:
                      TextStyle(fontSize: FontSizes.large, color: Colors.black),
                ),
                subtitle: Text(
                  description,
                  style: TextStyle(
                      fontSize: FontSizes.medium,
                      color: Colorspalette.subTitleColor),
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(10),
              onPressed: () {
                goToStoresPage();
              },
              child: Text(
                FlutterI18n.translate(context, "see_all"),
                style: TextStyle(
                    fontSize: FontSizes.small,
                    color: Colorspalette.valuAccentColor),
              ),
              color: Colorspalette.lightValuAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side:
                      const BorderSide(color: Colors.transparent, width: 2.0)),
            )
          ],
        ));
  }

  Widget _buildSectionDetails(List<Vendor> vendors) {
    if (vendors == null || vendors.length == 0) return Container();
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: CarouselSlider(
            height: 260.0,
            enableInfiniteScroll: true,
            initialPage: 0,
            viewportFraction: 0.655,
            aspectRatio: 1,
            items: vendors.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: 250, //MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 0.0),
                      child: VendorCard(
                        i,
                        onTab: () {
                          _homeSectionsBloc.dispatch(
                              FetchVendorBranchesEvent(vendorId: i.id));
                        },
                      ));
                },
              );
            }).toList(),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 20,
              height: 260,
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-10.0, 0),
                      blurRadius: 15.0,
                      spreadRadius: 5),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 20,
              height: 260,
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(10.0, 0),
                      blurRadius: 15.0,
                      spreadRadius: 5),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void showBranchesSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ListTile(
                  title: Text(
                    FlutterI18n.translate(context, "choose_branch"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: FontSizes.large),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      children: branchList.map((f) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Dialogs.showMsgDialog(
                                context,
                                null,
                                FlutterI18n.translate(
                                    context, "login_first_message"), () {
                              Navigator.pushNamed(
                                  context, LandingPage.routeName);
                            });
                          },
                          title: Text(f.name),
                        ),
                        Divider(
                          color: Colors.black,
                        )
                      ],
                    );
                  }).toList()),
                ),
              )
            ],
          );
        });
  }

  void goToStoresPage() {
    Navigator.push(context, PageRouteBuilder(
        pageBuilder: (BuildContext context, animation1, animation2) {
      return Scaffold(
          appBar: ValuAppBarWidget(
              showLogo: false,
              barTitle: FlutterI18n.translate(context, "all_vendors"),
              showSideMenu: false,
              showBackButton: true,
              drawerToggle: () => Navigator.of(context).pop()).build(context),
          body: SlideTransition(
            position: Tween<Offset>(begin: Offset(0.0, 0.10), end: Offset.zero)
                .animate(animation1),
            child: StoresPage(valuRepository: widget.valuRepository),
          ));
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
