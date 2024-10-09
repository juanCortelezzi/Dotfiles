use models::{EwwWorkspace, HyprctlMonitor, HyprctlWorkspace};
use std::{ffi::OsStr, io, process::Command};
use tokio::net::UnixStream;

// const SEARCH_FOR: [&str; 4] = [
//     "workspace",
//     "createworkspace",
//     "destroyworkspace",
//     "fullscreen",
// ];

fn command(name: &str, cmd_and_args: &[impl AsRef<OsStr>]) -> Vec<u8> {
    let command = Command::new(&cmd_and_args[0])
        .args(&cmd_and_args[1..])
        .output()
        .unwrap_or_else(|_| panic!("Failed to run {}", name));

    if !command.status.success() {
        let err = String::from_utf8(command.stderr)
            .unwrap_or("could not even process stderr as valid utf8".to_string());

        panic!("{} gave an error: {}", name, err);
    }

    command.stdout
}

fn hyprctl_workspaces(active_workspace_name: Option<&str>) -> Vec<EwwWorkspace> {
    let data = command("hyprctl workspaces", &["hyprctl", "workspaces", "-j"]);

    let workspaces: Vec<HyprctlWorkspace> =
        serde_json::from_slice(&data).expect("Failed to parse json from hyprctl workspaces");

    let mut workspaces: Vec<EwwWorkspace> = workspaces
        .into_iter()
        .map(|workspace| {
            let mut workspace = EwwWorkspace::from(workspace);
            workspace.is_active = active_workspace_name.is_some_and(|name| name == workspace.name);
            workspace
        })
        .filter(|workspace| workspace.windows > 0 || workspace.is_active)
        .collect();

    workspaces.sort_unstable_by_key(|workspace| workspace.id);

    workspaces
}

fn hyprctl_monitors() -> Vec<HyprctlMonitor> {
    let data = command("hyprctl monitors", &["hyprctl", "monitors", "-j"]);
    serde_json::from_slice(&data).expect("Failed to parse json from hyprctl monitors")
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let hypr_instance = std::env::var("HYPRLAND_INSTANCE_SIGNATURE")?;
    let xdg_runtime_dir = std::env::var("XDG_RUNTIME_DIR")?;
    let socket_path = format!("{}/hypr/{}/.socket2.sock", xdg_runtime_dir, hypr_instance);
    let stream = UnixStream::connect(socket_path).await?;

    let mut active_workspace_name = hyprctl_monitors()
        .first()
        .unwrap()
        .active_workspace
        .name
        .to_owned();

    println!(
        "{}",
        serde_json::to_string(&hyprctl_workspaces(Some(&active_workspace_name)))?
    );

    loop {
        stream.readable().await?;

        let mut data = vec![0; 1024];

        match stream.try_read(&mut data) {
            // Try to read data, this may still fail with `WouldBlock`
            // if the readiness event is a false positive.
            Err(ref e) if e.kind() == io::ErrorKind::WouldBlock => continue,
            Err(e) => return Err(e.into()),
            Ok(0) => return Ok(()),
            Ok(n) => {
                let workspace = core::str::from_utf8(&data[0..n])?
                    .lines()
                    .rev()
                    .flat_map(|line| line.split_once(">>"))
                    .find(|&(event, _)| event == "workspace")
                    .map(|(_, value)| value.to_string());

                if let Some(workspace) = workspace {
                    active_workspace_name = workspace;
                }

                let workspaces = hyprctl_workspaces(Some(&active_workspace_name));
                println!("{}", serde_json::to_string(&workspaces)?);
            }
        }
    }
}
