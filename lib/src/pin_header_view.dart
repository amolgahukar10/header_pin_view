import 'package:flutter/material.dart';
import 'package:header_pin_view/src/sticky_header_delegate.dart';

/// HeaderPinnedView.
class HeaderPinnedView extends StatefulWidget {
  final Widget headerSliverBuilder;
  final Widget sliverPersistentHeader;
  final Widget body;
  final bool pinned;
  final Color? backgroundColor;
  final double sliverPersistentHeaderHeight;
  const HeaderPinnedView({
    super.key,
    required this.headerSliverBuilder,
    required this.sliverPersistentHeader,
    required this.body,
    this.backgroundColor,
    required this.sliverPersistentHeaderHeight,
    this.pinned = true,
  });

  @override
  State<HeaderPinnedView> createState() => _SliverHeaderPinnedViewState();
}

class _SliverHeaderPinnedViewState extends State<HeaderPinnedView> {
  late ScrollController _scrollController;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController()..addListener(() {
          final maxScroll = widget.sliverPersistentHeaderHeight;
          final currentScroll = _scrollController.offset;
          setState(() {
            _scrollProgress = (currentScroll / maxScroll).clamp(0.0, 1.0);
          });
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder:
          (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Transform.scale(
                scale: 1.0 - (_scrollProgress * 0.1),
                child: Opacity(
                  opacity: 1.0 - (_scrollProgress * 0.4),
                  child: Column(
                    children: [
                      Column(children: [widget.headerSliverBuilder]),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: widget.pinned,
              delegate: StickyHeaderDelegate(
                height: widget.sliverPersistentHeaderHeight,
                child: Container(
                  color: widget.backgroundColor ?? Colors.white,
                  child: Column(children: [widget.sliverPersistentHeader]),
                ),
              ),
            ),
          ],
      body: SingleChildScrollView(child: Column(children: [widget.body])),
    );
  }
}
