import 'package:flutter/material.dart';
import 'package:myportfolio/widgets/hero_section.dart';
import 'package:myportfolio/widgets/about_section.dart';
import 'package:myportfolio/widgets/skills_section.dart';
import 'package:myportfolio/widgets/services_section.dart';
import 'package:myportfolio/widgets/projects_section.dart';
import 'package:myportfolio/widgets/testimonials_section.dart';
import 'package:myportfolio/widgets/resume_section.dart';
import 'package:myportfolio/widgets/contact_section.dart';
import 'package:myportfolio/widgets/footer_section.dart';
import 'package:myportfolio/widgets/floating_nav_bar.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(8, (_) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(key: _sectionKeys[0]),
            AboutSection(key: _sectionKeys[1]),
            SkillsSection(key: _sectionKeys[2]),
            ServicesSection(key: _sectionKeys[3]),
            ProjectsSection(key: _sectionKeys[4]),
            TestimonialsSection(key: _sectionKeys[5]),
            // ResumeSection(key: _sectionKeys[6]),
            ContactSection(key: _sectionKeys[7]),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
