#!/usr/bin/env python3
# File:        main.py
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     21 Jun 2021
# SPDX-License-Identifier: MIT

import argparse
from datetime import date
from pathlib import Path
import re
from typing import Dict

import toml


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

    # Setup parser
    parser = argparse.ArgumentParser()
    # Positional arguments
    parser.add_argument(
        "file",
        type=str,
        help="target file to create",
    )
    # Optional arguments
    parser.add_argument(
        "-b",
        "--box",
        action="store_true",
        help="apply a box decoration to the header",
    )
    parser.add_argument(
        "-f",
        "--force",
        action="store_true",
        help="force creation of the target file",
    )
    parser.add_argument(
        "-t",
        "--template",
        type=str,
        default="basic.txt",
        help="source code header template",
    )
    parser.add_argument(
        "--confdir",
        type=str,
        default="~/.config/mksrc",
        help="mksrc config home directory (default: ~/.config/mksrc)",
    )
    for attr in attrs:  # add overrides for all attributes
        parser.add_argument(f"--{attr}", type=str, help=f"{attr} string attribute")
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
    config = toml.load(args.config)

    # Ensure the output file does not exist
    if args.opath.exists() and not args.force:
        raise FileExistsError

    # Update commentstrings from defaults
    cms = commentstrings()
    cms.update(config.get("commentstrings") or {})
    config["commentstrings"] = cms

    # Update attributes from config
    attrs.update(config["attributes"])
    # Autofill any missing attributes
    for attr in attrs:
        if args.__dict__.get(attr):
            attrs[attr] = args.__dict__[attr]
    # Set any missing mandatory attributes
    if not attrs.get("comment"):
        attrs["comment"] = (
            cms[args.opath.suffix]
            if cms.get(args.opath.suffix)
            else (input("Comment: ") or "#")
        )
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
    if args.box:
        header = box(attrs, header)

    # Split the header into lines
    header = header.splitlines()
    # Strip trailing whitespace
    header = map(str.strip, header)
    # Filter out missing attributes
    header = filter(lambda line: not re.search("__([A-Z]+)__", line), header)
    # Insert commentstrings
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


def commentstrings() -> Dict[str, str]:
    cms = dict()
    # '"'
    for ft in [".vim"]:
        cms[ft] = '" %s'
    # '#'
    for ft in [".py", ".sh"]:
        cms[ft] = "# %s"
    # '--'
    for ft in [".lua"]:
        cms[ft] = "-- %s"
    # '//'
    for ft in [".c", ".cc", ".cpp", ".h", ".java", ".rs"]:
        cms[ft] = "// %s"
    # '<!-- -->'
    for ft in [".html", ".md"]:
        cms[ft] = "<!-- %s -->"
    # Return commentstrings
    return cms


def box(attrs, header: str) -> str:
    # Split lines from the header
    lines = header.splitlines()
    # Extract the comment string
    comment = attrs["comment"]
    # Determine the box horizontal length
    length = 80 - len(comment % "│  │")
    # Insert vertical box borders
    for i, line in enumerate(lines):
        lines[i] = f"│ {line:{length}} │\n"
    # Insert horizontal box borders
    top = f"┌─{'─' * length}─┐\n"
    bottom = f"└─{'─' * length}─┘\n"
    lines.insert(0, top)
    lines.append(bottom)
    # Rejoin and return the modified header
    return "".join(lines)


if __name__ == "__main__":
    main()
