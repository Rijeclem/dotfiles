#!/usr/bin/env python3

from rich.console import Console

TEXT = """
[cyan]You Got An Urge[/]

• [bright_purple on red] STOP IMMEDIATLY. YOU ARE REQUIRED TO READ THIS!!!! [/]

[purple]In case of: Morning Wood[/]
  1. Deep Breathe & Hold Breathe
  2. Looking at Walls
  3. Thinking about [yellow]Dostoyevsky / Stoicism / SR / God / Holy Mary[/]
  4. [black on yellow] Pushups if erection [/]

[purple]In case of: Boredom[/]
  1. Check on Basenote to see what you have to do
     [dim]reading a book is always a sound choice[/]
  2. Don't pace — it is [yellow]time wasted[/]

[purple]In case of: Sudden Urge / Trigger Response[/]
  1. Focus on something else immediately
     • Forefront effort only
     • Failure leads to [purple on red] Stuck on Brain [/]

[purple]In case of: Stuck on Brain[/]
  1. Check SR on Basenote
     • Read until you are [black on green] CERTAIN the idea is dead [/]
     • If it returns — read again

[purple]In case of: Depression / Giving Up[/]
  1. Review your [green]work, Basenote, SR, achievements[/]
  2. Check TV playlist
  3. Lay down and [cyan]listen to classical music[/]
  4. PMO has a [purple on red] 0% chance [/] of fixing this

[purple]In case of: Stress[/]
  1. Lay down
  2. Deep breathing & meditation
  3. [cyan]Ambient music[/]

[magenta]Technique: Archon Fight / Psychic Defense[/]
  • Recognize that [purple on red] you are being attacked [/]
  • Archons fear [yellow]Truth[/] — use it as a shield
  • Seeing and recognizing them wounds them
  • [yellow]YOU ARE BEING CONDITIONED TO LOSE[/]

[magenta]Technique: Listen to your Heart[/]
  • 99.99% of the time it is trickery
  • Hand on heart — it rejects these thoughts

[purple on blue] MOST IMPORTANT ELEMENT: SRBOOT [/]
  • These methods must activate immediately
  • Terminal is the final station
"""

def main():
    console = Console(markup=True)
    console.clear()
    console.rule("[red]SR BOOT[/]")
    console.print(TEXT)
    console.rule("[red]END[/]")

if __name__ == "__main__":
    main()
