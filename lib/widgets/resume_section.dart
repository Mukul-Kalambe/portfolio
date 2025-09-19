import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeSection extends StatefulWidget {
  const ResumeSection({super.key});

  @override
  State<ResumeSection> createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<ResumeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 768 && size.width <= 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionTitle(),
          const SizedBox(height: 60),
          _buildResumeCard(isDesktop, isTablet),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Column(
      children: [
        Text(
          'Resume',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [Color(0xFF00FFA3), Color(0xFF9D4EDD)],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Download my complete professional profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildResumeCard(bool isDesktop, bool isTablet) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: isDesktop ? 600 : double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF1A1A2E).withValues(alpha: 0.8),
              border: Border.all(
                color: const Color(0xFF00D4FF).withValues(alpha: 0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D4FF).withValues(alpha: _glowAnimation.value * 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: const Color(0xFF9D4EDD).withValues(alpha: _glowAnimation.value * 0.2),
                  blurRadius: 60,
                  spreadRadius: 15,
                ),
              ],
            ),
            child: Column(
              children: [
                // Resume preview icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF00D4FF).withValues(alpha: 0.1),
                    border: Border.all(
                      color: const Color(0xFF00D4FF).withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.description,
                    size: 60,
                    color: Color(0xFF00D4FF),
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  'Professional Resume',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Get a comprehensive overview of my experience, skills, education, and achievements in mobile app development.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Resume highlights
                _buildResumeHighlights(),

                const SizedBox(height: 40),

                // Action buttons
                if (isDesktop) ...[
                  Row(
                    children: [
                      Expanded(child: _buildActionButton('View Resume', Icons.visibility, false)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildActionButton('Download PDF', Icons.download, true)),
                    ],
                  ),
                ] else ...[
                  _buildActionButton('View Resume', Icons.visibility, false),
                  const SizedBox(height: 16),
                  _buildActionButton('Download PDF', Icons.download, true),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResumeHighlights() {
    final highlights = [
      {'icon': Icons.work, 'text': '5+ Years Experience'},
      {'icon': Icons.apps, 'text': '50+ Projects Completed'},
      {'icon': Icons.star, 'text': '100% Client Satisfaction'},
      {'icon': Icons.school, 'text': 'Computer Science Degree'},
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: highlights.map((highlight) => _buildHighlightItem(
        highlight['icon'] as IconData,
        highlight['text'] as String,
      )).toList(),
    );
  }

  Widget _buildHighlightItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF9D4EDD).withValues(alpha: 0.1),
        border: Border.all(
          color: const Color(0xFF9D4EDD).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF9D4EDD),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, bool isPrimary) {
    final color = isPrimary ? const Color(0xFF00D4FF) : const Color(0xFF9D4EDD);

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: isPrimary ? [
              BoxShadow(
                color: color.withValues(alpha: _glowAnimation.value * 0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ] : null,
          ),
          child: ElevatedButton.icon(
            onPressed: () => _handleButtonPress(isPrimary),
            icon: Icon(icon, size: 20),
            label: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary ? color : color.withValues(alpha: 0.1),
              foregroundColor: isPrimary ? Colors.white : color,
              side: BorderSide(
                color: color,
                width: isPrimary ? 0 : 2,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleButtonPress(bool isDownload) {
    if (isDownload) {
      _launchURL('https://example.com/mukul-kalambe-resume.pdf');
      _showDownloadSnackbar();
    } else {
      _launchURL('https://example.com/resume-preview');
    }
  }

  void _showDownloadSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.download_done, color: Color(0xFF00FFA3)),
            const SizedBox(width: 12),
            const Text('Resume download started!'),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFF00FFA3),
            width: 1,
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}