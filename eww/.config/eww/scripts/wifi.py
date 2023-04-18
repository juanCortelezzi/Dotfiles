#!/usr/bin/python

import subprocess
from typing import Any


def spit(x: Any):
    print(x, flush=True)


def main():
    wifi_cmd = subprocess.run(
        ["nmcli", "-t", "-f", "active,ssid", "dev", "wifi", "list"],
        capture_output=True,
        text=True,
    )

    if wifi_cmd.returncode != 0:
        spit("unable to read wifi")

    search_for = "yes:"

    ssid_list = list(
        filter(lambda line: line.startswith(search_for), wifi_cmd.stdout.split("\n"))
    )

    if len(ssid_list) < 1:
        return spit("󰤯 No wifi?")

    spit(f"󰤥 {ssid_list[0][len(search_for) :]}")


if __name__ == "__main__":
    main()
