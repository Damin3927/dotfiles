use walkdir::WalkDir;

use crate::{
    error::{Error, Result},
    utils::{get_lines_of_file, is_installed, run_command_in_shell, run_command_silently},
};

fn install_apt_packages() -> Result<()> {
    let installed_packages_stdout =
        run_command_silently("dpkg-query", &["-W", "-f='${binary:Package}\n'"])?;
    let installed_packages: Vec<&str> = installed_packages_stdout.lines().collect();

    let target_apt_packages = get_lines_of_file("init/apt_packages")?;
    let ignore_files = get_lines_of_file("init/.installignore")?;

    for package in target_apt_packages {
        if ignore_files.contains(&package) {
            println!("{} is marked to be skipped.", package);
            continue;
        }

        if installed_packages.contains(&package.as_str()) {
            println!("{} is already installed. Skipped.", package);
            continue;
        }

        println!("### Installing {} ###", package);
        run_command_in_shell("sudo", &["apt-get", "install", "-y", &package])
            .map_err(|e| Error::CommandError("sudo".to_owned(), e.to_string()))?;
        println!("Installed {}!", package);
    }

    Ok(())
}

fn install_other_pkgs() -> Result<()> {
    let init_dir = "init";

    for entry in WalkDir::new(init_dir)
        .sort_by_file_name()
        .into_iter()
        .filter_map(|e| e.ok())
        .filter(|e| e.file_type().is_dir())
        .filter(|e| e.file_name() != "init")
    {
        let dir_name = entry.file_name().to_str().unwrap();
        if is_installed(init_dir, dir_name) {
            println!("{} is already installed. Skipped.", dir_name);
            continue;
        }

        let filename = format!("{}/install.sh", entry.path().display());
        println!("### Installing {} ... ###", dir_name);
        run_command_in_shell("bash", &[&filename])
            .map_err(|e| Error::CommandError("bash".to_owned(), e.to_string()))?;
        println!("Installed {}!", dir_name);
    }
    Ok(())
}

pub fn run() -> Result<()> {
    install_apt_packages()?;
    install_other_pkgs()?;
    Ok(())
}
