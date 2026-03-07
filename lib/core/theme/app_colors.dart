import 'package:flutter/material.dart';

/// Design tokens extracted from Stitch MCP — OCR Processing project.
/// customColor: #137FEC | colorMode: LIGHT | saturation: 2
class AppColors {
  AppColors._();

  // ── Primary ──────────────────────────────────────────
  static const primary = Color(0xFF1A227F);
  static const primaryDark = Color(0xFF121858);
  static const primaryLight = Color(0xFFE8EAF6);

  // ── Secondary / Success ──────────────────────────────
  static const secondary = Color(0xFF009688);
  static const secondaryLight = Color(0xFFE0F2F1);

  // ── Semantic ─────────────────────────────────────────
  static const error = Color(0xFFEF4444);
  static const errorLight = Color(0xFFFEE2E2);
  static const warning = Color(0xFFF59E0B);
  static const warningLight = Color(0xFFFEF3C7);

  // ── Surfaces ─────────────────────────────────────────
  static const surface = Color(0xFFFFFFFF);
  static const background = Color(0xFFF5F7FA);
  static const scaffoldBackground = Color(0xFFF5F7FA);

  // ── Text ─────────────────────────────────────────────
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);

  // ── Borders & Dividers ───────────────────────────────
  static const divider = Color(0xFFE5E7EB);
  static const border = Color(0xFFD1D5DB);

  // ── Shadows ──────────────────────────────────────────
  static const cardShadow = Color(0x1A0A0A0A); // 10% opacity

  // ── Bottom Navigation ────────────────────────────────
  static const bottomNavActive = Color(0xFF137FEC);
  static const bottomNavInactive = Color(0xFF9CA3AF);
}
