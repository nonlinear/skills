# I Ching Skill

**Purpose:** Convert trigram throws to hexagram numbers and search in "I Ching of the Cosmic Way"

## Usage

When Nicholas says "joguei I Ching, deu X acima e Y embaixo":

1. **Run the converter:**
   ```bash
   ~/.openclaw/skills/iching/iching.sh <top> <bottom>
   ```

2. **Get hexagram number** from output

3. **Search in book:**
   ```bash
   cd ~/Documents/librarian/engine/scripts
   python3 research.py "hexagram <NUMBER> <context keywords>"
   ```

4. **Present results** with interpretation

## Trigram Table

| Nº | Nome | Trigrama | Símbolo Natural |
|----|------|----------|-----------------|
| 1 | Ch'ien | ☰ | Air, Creative |
| 2 | K'un | ☷ | Earth |
| 3 | Chên | ☳ | Thunder |
| 4 | K'an | ☵ | Water, Abysm |
| 5 | Kên | ☶ | Mountain, Stillness |
| 6 | Sun | ☴ | River, Wood |
| 7 | Li | ☲ | Fire, Light |
| 8 | Tui | ☱ | Lake |

## Example

```bash
# Nicholas: "3 acima, 5 embaixo"
~/.openclaw/skills/iching/iching.sh 3 5

# Output: Hexagram 27
# Then search:
cd ~/Documents/librarian/engine/scripts
python3 research.py "hexagram 27 nourishment providing"
```

## Triggers

- "joguei I Ching"
- "deu X acima/em cima e Y embaixo"
- "consulta I Ching"
- Números de trigramas (1-8)

## Integration

This skill combines:
- Trigram-to-hexagram conversion (iching.sh)
- Book search (librarian research.py)
- Carol K. Anthony's "I Ching of the Cosmic Way"

**Always cite the book when interpreting!**
