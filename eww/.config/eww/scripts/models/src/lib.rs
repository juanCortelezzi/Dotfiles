use serde::{Deserialize, Serialize};

#[derive(Deserialize, Debug)]
pub struct HyprctlMonitorActiveWorkspace {
    pub name: String,
}

#[derive(Deserialize, Debug)]
pub struct HyprctlMonitor {
    #[serde(rename = "activeWorkspace")]
    pub active_workspace: HyprctlMonitorActiveWorkspace,
}

#[derive(Deserialize, Debug)]
pub struct HyprctlWorkspace {
    pub id: u32,
    pub name: String,
    // monitor: String,
    pub windows: u32,

    #[serde(rename = "hasfullscreen")]
    pub has_full_screen: bool,
    // lastwindowtitle: String,
}

#[derive(Serialize)]
pub struct EwwWorkspace {
    pub id: u32,
    pub name: String,
    pub windows: u32,

    #[serde(rename = "hasfullscreen")]
    pub has_full_screen: bool,

    #[serde(rename = "isactive")]
    pub is_active: bool,
}

impl From<HyprctlWorkspace> for EwwWorkspace {
    fn from(value: HyprctlWorkspace) -> Self {
        Self {
            id: value.id,
            name: value.name,
            windows: value.windows,
            has_full_screen: value.has_full_screen,
            is_active: false,
        }
    }
}
