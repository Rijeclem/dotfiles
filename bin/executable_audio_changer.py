#!/usr/bin/env python3

import subprocess
import re


def parse_wpctl_status():
    result = subprocess.run(
        ["wpctl", "status"],
        capture_output=True,
        text=True,
        check=True
    )

    lines = result.stdout.splitlines()

    sinks = []
    in_sinks = False

    for line in lines:
        if re.search(r"Sinks:\s*$", line):
            in_sinks = True
            continue

        if not in_sinks:
            continue

        if re.search(r"^(.*)(Sources|Filters|Streams):\s*$", line):
            break

        clean = (
            line
            .replace("├", "")
            .replace("─", "")
            .replace("│", "")
            .replace("└", "")
            .strip()
        )

        match = re.match(r"^\*?\s*(\d+)\.\s+(.+?)(?:\s+\[vol:.*)?$", clean)

        if not match:
            continue

        sink_id = int(match.group(1))
        sink_name = match.group(2).strip()
        is_default = clean.startswith("*")

        sinks.append({
            "sink_id": sink_id,
            "sink_name": sink_name,
            "default": is_default
        })

    return sinks


sinks = parse_wpctl_status()

if not sinks:
    print("No sinks found.")
    exit(1)


# Build Wofi input
wofi_lines = []

for sink in sinks:
    if sink["default"]:
        wofi_lines.append(f"{sink['sink_name']} - Default")
    else:
        wofi_lines.append(sink["sink_name"])

wofi_input = "\n".join(wofi_lines)


# Run Wofi directly.
# Wofi automatically loads ~/.config/wofi/config and ~/.config/wofi/style.css
wofi_process = subprocess.run(
    [
        "wofi",
        "--show=dmenu",
        "--hide-scroll",
        "--allow-markup",
        "--location=top_right",
        "--width=600",
        "--height=200",
        "--xoffset=-60",
        "--style",
        "/home/rad/.config/wofi/styles.css"
    ],
    input=wofi_input,
    text=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)


if wofi_process.returncode != 0:
    exit(0)


selected = wofi_process.stdout.strip()

# Remove our visual formatting
selected = re.sub(r"^->\s*", "", selected)
selected = re.sub(r"\s+- Default$", "", selected)


# Find the selected sink
selected_sink = next(
    (sink for sink in sinks if sink["sink_name"] == selected),
    None
)

if selected_sink is None:
    print(f"Could not find sink: {selected!r}")
    exit(1)


subprocess.run(
    ["wpctl", "set-default", str(selected_sink["sink_id"])],
    check=True
)
