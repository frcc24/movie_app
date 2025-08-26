import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../core/model/actor.dart';

class CastSectionWidget extends StatelessWidget {
  final List<Actor> castMembers;

  const CastSectionWidget({
    super.key,
    required this.castMembers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Elenco Principal',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.contentWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 2.h),

          SizedBox(
            height: 20.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: castMembers.length,
              itemBuilder: (context, index) {
                final castMember = castMembers[index];
                return Container(
                  width: 25.w,
                  margin: EdgeInsets.only(right: 3.w),
                  child: Column(
                    children: [
                      Container(
                        width: 20.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.borderColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomImageWidget(
                            imageUrl:
                                castMember.photo ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
                            width: 20.w,
                            height: 12.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: 1.h),

                      Text(
                        castMember.name,
                        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.contentWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 0.5.h),

                      Text(
                        castMember.role,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.mutedText,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
