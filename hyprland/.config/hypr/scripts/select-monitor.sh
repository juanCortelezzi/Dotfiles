#!/usr/bin/bash
MONITOR_DEFAULT_NAME='eDP-1'
MONITOR_DEFAULT_CONFIG="$MONITOR_DEFAULT_NAME,1920x1080@60,0x0,1.5"

MONITORS_JSON=$(hyprctl monitors all -j)
if [[ -z "$MONITORS_JSON" ]]; then
  echo "ERROR::HYPR hyprland did not print any monitors"
  exit 1
fi

MONITOR_SELECTED=$(echo "$MONITORS_JSON" | jq -r '.[] | "\(.name)::\(.id)"' | tofi)
if [[ -z "$MONITOR_SELECTED" ]]; then
  echo "ERROR::SCRIPT no monitor selected"
  exit 1
fi

MONITOR_SELECTED_NAME=$(echo "$MONITOR_SELECTED" | cut -d ':' -f 1)
echo "INFO::SCRIPT selected monitor: $MONITOR_SELECTED_NAME"

MONITORS_OTHER_NAMES=$(echo "$MONITORS_JSON" | jq -r ".[] | select(.name != \"$MONITOR_SELECTED_NAME\") | \"\(.name)\"")

EWW_WINDOWS_OPEN=$(eww list-windows)

if [[ -n $EWW_WINDOWS_OPEN ]]; then
  while IFS= read -r EWW_WINDOW || [[ -n $EWW_WINDOW ]]; do
    echo "INFO::EWW closing $EWW_WINDOW"
    eww close "$EWW_WINDOW" >/dev/null || echo "ERROR::EWW failed to close window '$EWW_WINDOW'"
  done <<<"$EWW_WINDOWS_OPEN"
fi

if [[ -n $MONITORS_OTHER_NAMES ]]; then
  while IFS= read -r MONITOR_NAME || [[ -n "$MONITOR_NAME" ]]; do
    echo "INFO::HYPR disable monitor: $MONITOR_NAME"
    hyprctl keyword monitor "$MONITOR_NAME,disable" -q || echo "ERROR::HYPR failed to disable monitor '$MONITOR_NAME'"
  done <<<"$MONITORS_OTHER_NAMES"
fi

sleep 3

if [[ "$MONITOR_SELECTED_NAME" == "$MONITOR_DEFAULT_NAME" ]]; then
  echo "INFO::HYPR setting default monitor"
  hyprctl keyword monitor "$MONITOR_DEFAULT_CONFIG" -q || echo "ERROR::HYPR failed to set default monitor '$MONITOR_DEFAULT_CONFIG'"
else
  echo "INFO::HYPR setting unknown monitor"
  MONITOR_UNKNOWN_CONFIG="$MONITOR_SELECTED_NAME,preferred,auto,1"
  hyprctl keyword monitor "$MONITOR_UNKNOWN_CONFIG" -q || echo "ERROR::HYPR failed to set unknown monitor '$MONITOR_UNKNOWN_CONFIG'"
fi

sleep 3

hyprctl dispatch focusmonitor "$MONITOR_SELECTED_NAME" -q || echo "ERROR::HYPR failed to fous monitor '$MONITOR_SELECTED_NAME'"

WORKSPACE_IDS_IN_OTHER_MONITORS=$(hyprctl workspaces -j | jq -r ".[] | select(.monitor != \"$MONITOR_SELECTED_NAME\") | .id")
if [[ -n $WORKSPACE_IDS_IN_OTHER_MONITORS ]]; then
  while IFS= read -r WORKSPACE_ID; do
    echo "INFO::HYPR moving workspace ($WORKSPACE_ID)"
    hyprctl dispatch moveworkspacetomonitor "$WORKSPACE_ID" "$MONITOR_SELECTED_NAME" -q || echo "ERROR::HYPR failed to move workspaceId:($WORKSPACE_ID) to monitor '$MONITOR_SELECTED_NAME'"
  done <<<"$WORKSPACE_IDS_IN_OTHER_MONITORS"
fi

if [[ -n $EWW_WINDOWS_OPEN ]]; then
  while IFS= read -r EWW_WINDOW || [[ -n $EWW_WINDOW ]]; do
    echo "INFO::EWW opening $EWW_WINDOW"
    eww open "$EWW_WINDOW" >/dev/null || echo "ERROR::EWW failed to open window '$EWW_WINDOW'"
  done <<<"$EWW_WINDOWS_OPEN"
fi
