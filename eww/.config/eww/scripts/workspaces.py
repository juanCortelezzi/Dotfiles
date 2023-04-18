#!/usr/bin/python

import subprocess
import os
import socket
import json
from typing import TypedDict, Any

SEARCH_FOR = set(["workspace", "createworkspace", "destroyworkspace"])


class HyprctlWorkspace(TypedDict):
    id: int
    name: str
    monitor: str
    windows: int
    hasfullscreen: bool
    lastwindowtitle: str


class HyprctlActiveWorkspace(TypedDict):
    id: int
    name: str


class HyprctlMonitor(TypedDict):
    id: int
    name: str
    description: str
    make: str
    model: str
    serial: str
    width: int
    height: int
    refreshRate: float
    x: int
    y: int
    activeWorkspace: HyprctlActiveWorkspace
    reserved: list[int]
    scale: float
    transform: int
    focused: bool
    dpmsStatus: bool
    vrr: bool


class Workspace(TypedDict):
    id: int
    name: str
    windows: int
    hasfullscreen: bool
    isactive: bool


def spit(x: str):
    print(x, flush=True)


def to_json(x: Any):
    try:
        return json.dumps(
            x,
            skipkeys=True,
            check_circular=False,
            ensure_ascii=False,
        )
    except ValueError:
        return "could not dump json"


def get_workspaces(active_workspace: str | None = None) -> list[Workspace] | None:
    data = subprocess.run(["hyprctl", "workspaces", "-j"], capture_output=True)

    if data.returncode != 0:
        return spit("error in hyprctl workspaces")

    x: list[HyprctlWorkspace] = []
    try:
        x = json.loads(data.stdout)
    except ValueError:
        return spit("error parsing workspaces json")

    return list(
        sorted(
            map(
                lambda w: Workspace(
                    id=w["id"],
                    name=w["name"],
                    windows=w["windows"],
                    hasfullscreen=w["hasfullscreen"],
                    isactive=w["name"] == active_workspace,
                ),
                x,
            ),
            key=lambda x: x["id"],
        )
    )


def get_active_workspace():
    # hyprctl monitors -j | jq --raw-output ".[0].activeWorkspace.id"
    data = subprocess.run(["hyprctl", "monitors", "-j"], capture_output=True)

    if data.returncode != 0:
        return spit("error in hyprctl monitors")

    x: list[HyprctlMonitor] = []
    try:
        x = json.loads(data.stdout)
    except ValueError:
        return spit("error parsing monitors json")

    return x[0]["activeWorkspace"]["name"]


def main():
    active_workspace = get_active_workspace()
    spit(to_json(get_workspaces(active_workspace)))

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect(f'/tmp/hypr/{os.environ["HYPRLAND_INSTANCE_SIGNATURE"]}/.socket2.sock')

    while True:
        event = sock.recv(4096).decode("utf-8")
        # event_loop()

        for item in event.split("\n"):
            [name, _, value] = item.partition(">>")
            if name not in SEARCH_FOR:
                continue

            if name == "workspace":
                active_workspace = value

            workspaces = get_workspaces(active_workspace)
            if not workspaces:
                continue

            spit(to_json(workspaces))


if __name__ == "__main__":
    main()
