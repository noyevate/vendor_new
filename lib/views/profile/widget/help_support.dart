import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchEmail() {
    _launchUrl('mailto:support@chopnow.com?subject=Vendor Support Request');
  }

  void _launchWhatsApp() {
    _launchUrl(
        'https://wa.me/2348000000000?text=Hello, I need help with my vendor account');
  }

  void _launchPhone() {
    _launchUrl('tel:+2348000000000');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: const PageTitle(title: "Help and Support"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Contact us section ---
            const _SectionHeader(title: "Contact us"),
            SizedBox(height: 16.h),
            _ContactTile(
              icon: HeroiconsOutline.chatBubbleLeftRight,
              title: "Live Chat",
              subtitle: "Chat with us on WhatsApp",
              onTap: _launchWhatsApp,
            ),
            SizedBox(height: 12.h),
            _ContactTile(
              icon: HeroiconsOutline.envelope,
              title: "Email Support",
              subtitle: "support@chopnow.com",
              onTap: _launchEmail,
            ),
            SizedBox(height: 12.h),
            _ContactTile(
              icon: HeroiconsOutline.phone,
              title: "Call Us",
              subtitle: "+234 800 000 0000",
              onTap: _launchPhone,
            ),

            SizedBox(height: 40.h),

            // --- FAQs section ---
            const _SectionHeader(title: "Frequently asked questions"),
            SizedBox(height: 16.h),
            const _FaqTile(
              question: "How do I get my restaurant verified?",
              answer:
                  "After creating your restaurant profile, our team will review your details within 24-48 hours. You'll receive a notification once your restaurant is verified.",
            ),
            const _FaqTile(
              question: "When do I receive my payouts?",
              answer:
                  "Payouts are triggered automatically once the customer confirms delivery using the PIN. Funds are transferred to your registered bank account within 1-3 business days.",
            ),
            const _FaqTile(
              question: "How do I update my operating hours?",
              answer:
                  "Go to your Profile → Restaurant details → Operating hours. You can set different hours for delivery and pickup for each day of the week.",
            ),
            const _FaqTile(
              question: "What happens if an order is placed when I'm closed?",
              answer:
                  "Our system automatically prevents orders from being placed outside your operating hours. You can also manually toggle your availability from your profile.",
            ),
            const _FaqTile(
              question: "How do I add or edit my menu items?",
              answer:
                  "Tap the + button on the Menu tab to add a new item. To edit an existing item, tap on it from the menu list and update the details.",
            ),
            const _FaqTile(
              question: "My account details are wrong, how do I fix this?",
              answer:
                  "Go to Profile → Payout details to update your bank account information. Note that changing bank details requires re-verification with Paystack.",
            ),

            SizedBox(height: 40.h),

            // --- App version ---
            Center(
              child: ReuseableText(
                title: "ChopNow Vendor v1.0.0",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Tcolor.TEXT_Label,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header
// ─────────────────────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ReuseableText(
      title: title,
      style: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: Tcolor.Text,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Contact tile
// ─────────────────────────────────────────────────────────────────────────────
class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Tcolor.White,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Tcolor.TEXT_Label.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: Tcolor.Primary_New.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32.sp,
                color: Tcolor.Primary_New,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    title: title,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Tcolor.Text,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ReuseableText(
                    title: subtitle,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Tcolor.TEXT_Label,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              HeroiconsOutline.chevronRight,
              size: 28.sp,
              color: Tcolor.TEXT_Label,
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  const _FaqTile({required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      _expanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Tcolor.White,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _expanded
              ? Tcolor.Primary_New.withOpacity(0.3)
              : Tcolor.TEXT_Label.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Row(
                children: [
                  Expanded(
                    child: ReuseableText(
                      title: widget.question,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500,
                        color: Tcolor.Text,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      HeroiconsOutline.chevronDown,
                      size: 28.sp,
                      color: Tcolor.TEXT_Label,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
              child: ReuseableText(
                title: widget.answer,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.TEXT_Label,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
