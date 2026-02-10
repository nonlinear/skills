#!/usr/bin/env python3
# I Ching Hexagram Lookup

import sys

TRIGRAMS = {
    1: ("Ch'ien", "☰", "Air, Creative"),
    2: ("K'un", "☷", "Earth"),
    3: ("Chên", "☳", "Thunder"),
    4: ("K'an", "☵", "Water, Abysm"),
    5: ("Kên", "☶", "Mountain, Stillness"),
    6: ("Sun", "☴", "River, Wood"),
    7: ("Li", "☲", "Fire, Light"),
    8: ("Tui", "☱", "Lake")
}

# Hexagram lookup: (UPPER_trigram, LOWER_trigram) -> hexagram_number
# UPPER = visual top (Nicholas says "X acima")
# LOWER = visual bottom (Nicholas says "Y embaixo")
# Example: "3-5" = Chên (3) on top, Kên (5) on bottom
# But prompt table uses inverted notation: "Kên top, Chên bottom = 27"
# So we need to SWAP the order when looking up!

HEXAGRAMS = {
    # When LOWER = Ch'ien (1) - visually at BOTTOM
    ("Ch'ien", "Ch'ien"): 1, ("Chên", "Ch'ien"): 34, ("K'an", "Ch'ien"): 5, ("Kên", "Ch'ien"): 26,
    ("K'un", "Ch'ien"): 11, ("Sun", "Ch'ien"): 9, ("Li", "Ch'ien"): 14, ("Tui", "Ch'ien"): 43,
    
    # When LOWER = Chên (3) - visually at BOTTOM
    ("Ch'ien", "Chên"): 25, ("Chên", "Chên"): 51, ("K'an", "Chên"): 3, ("Kên", "Chên"): 27,
    ("K'un", "Chên"): 24, ("Sun", "Chên"): 42, ("Li", "Chên"): 21, ("Tui", "Chên"): 17,
    
    # When LOWER = K'an (4) - visually at BOTTOM
    ("Ch'ien", "K'an"): 6, ("Chên", "K'an"): 40, ("K'an", "K'an"): 29, ("Kên", "K'an"): 4,
    ("K'un", "K'an"): 7, ("Sun", "K'an"): 59, ("Li", "K'an"): 64, ("Tui", "K'an"): 47,
    
    # When LOWER = Kên (5) - visually at BOTTOM
    ("Ch'ien", "Kên"): 33, ("Chên", "Kên"): 62, ("K'an", "Kên"): 39, ("Kên", "Kên"): 52,
    ("K'un", "Kên"): 15, ("Sun", "Kên"): 53, ("Li", "Kên"): 56, ("Tui", "Kên"): 31,
    
    # When LOWER = K'un (2) - visually at BOTTOM
    ("Ch'ien", "K'un"): 12, ("Chên", "K'un"): 16, ("K'an", "K'un"): 8, ("Kên", "K'un"): 23,
    ("K'un", "K'un"): 2, ("Sun", "K'un"): 20, ("Li", "K'un"): 35, ("Tui", "K'un"): 45,
    
    # When LOWER = Sun (6) - visually at BOTTOM
    ("Ch'ien", "Sun"): 44, ("Chên", "Sun"): 32, ("K'an", "Sun"): 48, ("Kên", "Sun"): 18,
    ("K'un", "Sun"): 46, ("Sun", "Sun"): 57, ("Li", "Sun"): 50, ("Tui", "Sun"): 28,
    
    # When LOWER = Li (7) - visually at BOTTOM
    ("Ch'ien", "Li"): 13, ("Chên", "Li"): 55, ("K'an", "Li"): 63, ("Kên", "Li"): 22,
    ("K'un", "Li"): 36, ("Sun", "Li"): 37, ("Li", "Li"): 30, ("Tui", "Li"): 49,
    
    # When LOWER = Tui (8) - visually at BOTTOM
    ("Ch'ien", "Tui"): 10, ("Chên", "Tui"): 54, ("K'an", "Tui"): 60, ("Kên", "Tui"): 41,
    ("K'un", "Tui"): 19, ("Sun", "Tui"): 61, ("Li", "Tui"): 38, ("Tui", "Tui"): 58
}

if len(sys.argv) != 3:
    print("Usage: iching.sh <top_trigram_number> <bottom_trigram_number>")
    print("Example: iching.sh 3 5  # Trovão (3) acima, Montanha (5) embaixo")
    sys.exit(1)

try:
    top = int(sys.argv[1])
    bottom = int(sys.argv[2])
except ValueError:
    print("Error: Arguments must be numbers 1-8")
    sys.exit(1)

if top not in TRIGRAMS or bottom not in TRIGRAMS:
    print("Error: Invalid trigram number (must be 1-8)")
    sys.exit(1)

upper_name, upper_symbol, upper_desc = TRIGRAMS[top]  # Visual TOP (acima)
lower_name, lower_symbol, lower_desc = TRIGRAMS[bottom]  # Visual BOTTOM (embaixo)

# Lookup: Prompt table uses INVERTED notation!
# "top" in prompt = visual LOWER, "bottom" in prompt = visual UPPER
hexagram = HEXAGRAMS.get((lower_name, upper_name))

print("🔮 I Ching Hexagram Lookup")
print()
print(f"UPPER trigram (acima): {upper_symbol} {upper_name} ({upper_desc})")
print(f"LOWER trigram (embaixo): {lower_symbol} {lower_name} ({lower_desc})")
print()
print(f"Hexagram: {hexagram}")
print()
print(f"Visual representation:")
print(f"{upper_symbol} {upper_name}")
print(f"{lower_symbol} {lower_name}")
