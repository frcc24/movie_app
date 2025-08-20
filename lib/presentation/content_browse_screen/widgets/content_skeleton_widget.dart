import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ContentSkeletonWidget extends StatefulWidget {
  const ContentSkeletonWidget({super.key});

  @override
  State<ContentSkeletonWidget> createState() => _ContentSkeletonWidgetState();
}

class _ContentSkeletonWidgetState extends State<ContentSkeletonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.darkTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkeletonPoster(),
              _buildSkeletonContent(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkeletonPoster() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          width: double.infinity,
          color: AppTheme.borderColor.withValues(alpha: _animation.value * 0.3),
        ),
      ),
    );
  }

  Widget _buildSkeletonContent() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: AppTheme.borderColor
                  .withValues(alpha: _animation.value * 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            width: 50.w,
            height: 1.5.h,
            decoration: BoxDecoration(
              color: AppTheme.borderColor
                  .withValues(alpha: _animation.value * 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Container(
                width: 15.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: AppTheme.borderColor
                      .withValues(alpha: _animation.value * 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(width: 2.w),
              Container(
                width: 12.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: AppTheme.borderColor
                      .withValues(alpha: _animation.value * 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(width: 2.w),
              Container(
                width: 10.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: AppTheme.borderColor
                      .withValues(alpha: _animation.value * 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              ...List.generate(
                  5,
                  (index) => Padding(
                        padding: EdgeInsets.only(right: 1.w),
                        child: Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            color: AppTheme.borderColor
                                .withValues(alpha: _animation.value * 0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )),
              const Spacer(),
              Container(
                width: 15.w,
                height: 2.h,
                decoration: BoxDecoration(
                  color: AppTheme.borderColor
                      .withValues(alpha: _animation.value * 0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
