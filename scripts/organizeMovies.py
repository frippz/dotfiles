#!/usr/bin/env python3

import os
import sys
import argparse
from pathlib import Path


def create_subfolders(path: str, dry_run: bool):
    # Convert string path to Path object
    path = Path(path)

    if dry_run:
        print(f"Dry run")

    # Iterate over files in directory
    for file in path.glob("*"):
        # Ignore directories
        if not file.is_file() or file.name.startswith("."):
            continue

        # Get file name without extension
        name = file.stem

        # If name ends with .sv or .en, strip it
        if name.endswith(".sv") or name.endswith(".en"):
            name = name.rsplit(".", 1)[0]

        # Construct subfolder path
        subfolder = path / name

        # Print what would be done in dry run
        if dry_run:
            print(f"{file.name} => {path}/{subfolder}/")
        else:
            # Create directory if not exists
            subfolder.mkdir(exist_ok=True)

            # Move file into subfolder
            file.rename(subfolder / file.name)
            print(f"Created directory {subfolder} and moved {file.name} into it")


def main():
    parser = argparse.ArgumentParser(description="Organize files into subfolders.")
    parser.add_argument(
        "path", type=str, help="The path to the directory with files to organize."
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="If set, the script will only simulate the actions.",
    )

    args = parser.parse_args()

    create_subfolders(args.path, args.dry_run)


if __name__ == "__main__":
    main()
