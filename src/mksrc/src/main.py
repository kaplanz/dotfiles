#!/usr/bin/env python3
# File:        main.py
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     21 Jun 2021
# SPDX-License-Identifier: MIT

import argparse
import re
from datetime import date
from pathlib import Path

import toml


# fmt: off
BORDERS: dict[str, dict[str, str]] = {
        "ascii": {
            "dl": "+",
            "dr": "+",
            "hh": "-",
            "ul": "+",
            "ur": "+",
            "vv": "|",
        },
        "round": {
            "dl": "╮",
            "dr": "╭",
            "ul": "╯",
            "ur": "╰",
        },
        "sharp": {

    "dl": "┐",
    "dr": "┌",
    "hh": "─",
    "ul": "┘",
    "ur": "└",
    "vv": "│",
            },
        "star": {
            "dl": "*",
            "dr": "*",
            "hh": "*",
            "ul": "*",
            "ur": "*",
            "vv": "*",
        },
    }
# fmt: on

# fmt: off
LANGS: dict[str, str] = {
    # "
    "vim":  '" %s',
    # #
    "py":   "# %s",
    "sh":   "# %s",
    # --
    "lua":  "--",
    # //
    "c":    "// %s",
    "cc":   "// %s",
    "cpp":  "// %s",
    "h":    "// %s",
    "java": "// %s",
    "rs":   "// %s",
    # <!-- -->
    "html": "<!-- %s -->",
    "md":   "<!-- %s -->",
}
# fmt: on


def main():
    # Define all valid attributes
    attrs = {
        "author": None,
        "comment": None,
        "description": None,
        "email": None,
        "homepage": None,
        "license": "NONE",
        "version": None,
    }

    # Initialize parser
    parser = argparse.ArgumentParser()
    # fmt: off
    # Positional arguments
    parser.add_argument("file", type=str, help="target file to create")
    # Optional arguments
    parser.add_argument("-b", "--box", action="store_true",
                        help="apply a box decoration to the header")
    parser.add_argument("--box-style", type=str, default="round",
                        help="box decoration style")
    parser.add_argument("-f", "--force", action="store_true",
                        help="force creation of the target file")
    parser.add_argument("-t", "--template", type=str, default="basic.txt",
                        help="source code header template")
    parser.add_argument("--confdir", type=str, default="~/.config/mksrc",
                        help="mksrc config home directory (default: ~/.config/mksrc)")
    for attr in attrs:  # add overrides for all attributes
        parser.add_argument(f"--{attr}", type=str, help=f"{attr} attribute")
    # fmt: on
    # Parse args
    args = parser.parse_args()

    # Resolve paths
    args.confdir = Path(args.confdir).expanduser()
    args.config = args.confdir.joinpath("config.toml")
    args.opath = Path(args.file)
    args.templates = args.confdir.joinpath("templates")
    args.template = Path(args.template)
    if not args.template.is_file():
        args.template = args.templates.joinpath(args.template)

    # Override args
    args.file = args.opath.name

    # Read the config file
    try:
        config = toml.load(args.config)
    except:
        config = dict()

    # Ensure the output file does not exist
    if args.opath.exists() and not args.force:
        raise FileExistsError

    # Update commentstrings from defaults
    langs = dict()
    langs.update(LANGS)
    langs.update(config.get("languages") or {})
    config["languages"] = langs

    # Update attributes from config
    if attr := config.get("attributes"):
        attrs.update(attr)
    # Autofill any missing attributes
    for attr in attrs:
        if args.__dict__.get(attr):
            attrs[attr] = args.__dict__[attr]
    # Set any missing mandatory attributes
    if not attrs.get("comment"):
        if comment := langs.get(args.opath.suffix[1:]):
            attrs["comment"] = comment
        else:
            attrs["comment"] = input("Comment: ") or "#"
    attrs["comment"] += " %s" if "%s" not in attrs["comment"] else ""
    if not attrs.get("file"):
        attrs["file"] = args.opath.name

    # Create a header from the template
    with open(args.template, "r") as f:
        # Read the template file
        header = f.read()
        # Fill in attribute tags
        matches = re.finditer("__([A-Z]+)__", header)
        # Iterate all matches
        for match in matches:
            # Extract the attribute name, value
            attr = match.group(1)
            value = attrs.get(attr.lower())
            # Prompt the user for missing values
            if not value:
                value = input(f"{attr.title()}: ")
            # Continue if the value is still missing
            if not value:
                continue
            # Replace attribute tags with values
            header = header.replace(match.group(0), value)
        # Fill in any dates
        header = date.today().strftime(header)

    # Perform any decorations
    border = args.box_style
    if args.box:
        header = box(attrs, header, border)

    # Split the header into lines
    header = header.splitlines()
    # Strip trailing whitespace
    header = map(str.strip, header)
    # Filter out missing attributes
    header = filter(lambda line: not re.search("__([A-Z]+)__", line), header)
    # Insert language commentstrings
    header = map(lambda line: attrs["comment"] % line, header)
    # Add back newlines
    header = map(lambda line: "%s\n" % line, header)
    # Rejoin the header
    header = "".join(header)

    # Print the header
    print(header, end="")

    # Make intermediate output directories
    args.opath.parent.mkdir(exist_ok=True)

    # Write the header to the output file
    with open(args.opath, "w") as f:
        f.write(header)


def box(attrs, header: str, chars: dict[str, str] | str | None = None) -> str:
    # Define the charset if not defined
    match chars:
        case dict():
            pass
        case str():
            chars = BORDERS.get(chars)
            if not chars: raise ValueError
        case None:
            chars = BORDERS["ascii"]
        case _:
            raise TypeError
    # Split lines from the header
    lines = header.splitlines()
    # Extract the comment string
    comment = attrs["comment"]
    # Determine the box horizontal length
    length = 80 - len(comment % f"{chars['vv']}  {chars['vv']}")
    # Insert vertical box borders
    for i, line in enumerate(lines):
        lines[i] = f"{chars['vv']} {line:{length}} {chars['vv']}\n"
    # Insert horizontal box borders
    lfill = f"{chars['hh'] * length}"
    top = f"{chars['dr']}{lfill[0]}{lfill}{lfill[0]}{chars['dl']}\n"
    btm = f"{chars['ur']}{lfill[0]}{lfill}{lfill[0]}{chars['ul']}\n"
    lines.insert(0, top)
    lines.append(btm)
    # Rejoin and return the modified header
    return "".join(lines)


if __name__ == "__main__":
    main()
