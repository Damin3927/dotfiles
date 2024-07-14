use std::{
    fs::File,
    io::{BufRead, BufReader},
    path::Path,
    process::{Command, Stdio},
};

use crate::error::{Error, Result};

pub fn is_installed(init_dir: &str, executable: &str) -> bool {
    // Check if the command exists
    if run_command_silently("command", &["-v", executable]).is_ok() {
        return true;
    }

    // Check for custom install checker script
    let install_checker_path = format!("{}/{}/install_checker.sh", init_dir, executable);
    if Path::new(&install_checker_path).exists() {
        let check_command = format!(
            "source {} && is_{}_installed",
            install_checker_path, executable
        );
        if run_command_silently("bash", &["-c", &check_command]).is_ok() {
            return true;
        }
    }

    false
}

pub fn get_lines_of_file(filename: &str) -> Result<Vec<String>> {
    let file = File::open(filename).map_err(Error::IOError)?;
    let reader = BufReader::new(file);
    reader
        .lines()
        .collect::<std::result::Result<Vec<String>, _>>()
        .map_err(Error::IOError)
}

pub fn run_command_silently(cmd: &str, args: &[&str]) -> Result<String> {
    let output = Command::new(cmd)
        .args(args)
        .output()
        .map_err(Error::IOError)?;
    if !output.status.success() {
        return Err(Error::CommandError(
            format!("{} {:?}", cmd, args),
            String::from_utf8_lossy(&output.stderr).into_owned(),
        ));
    }
    Ok(String::from_utf8_lossy(&output.stdout).into_owned())
}

pub fn run_command_in_shell(name: &str, args: &[&str]) -> Result<()> {
    let status = Command::new(name)
        .args(args)
        .stdin(Stdio::inherit())
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()?;

    if !status.success() {
        return Err(Error::CommandError(
            name.to_owned(),
            format!("Failed to run command: {:?}", args),
        ));
    }

    Ok(())
}
