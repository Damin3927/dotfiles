use std::{fs::File, io::Write};

use walkdir::WalkDir;

use crate::{
    error::{Error, Result},
    utils::get_lines_of_file,
};

fn append_script(name: &str, original: &mut Vec<String>, appendee: &[String]) {
    let has_shebang = appendee.get(0).map_or(false, |line| line.starts_with("#!"));

    if (has_shebang && appendee.len() == 1) || (!has_shebang && appendee.is_empty()) {
        return;
    }

    original.push(format!("### {} init script", name));

    if has_shebang {
        original.extend_from_slice(&appendee[1..]);
    } else {
        original.extend_from_slice(appendee);
    }

    original.push(String::new());
    original.push(String::new());
}

pub fn run() -> Result<()> {
    let init_dir = "init";

    let mut result_script =
        vec!["# This script is generated automatically. DO NOT EDIT.".to_owned()];

    for entry in WalkDir::new(init_dir)
        .into_iter()
        .filter_map(|e| e.ok())
        .filter(|e| e.file_type().is_dir())
    {
        let filename = format!("{}/init.sh", entry.path().display());
        let lines = match get_lines_of_file(&filename) {
            Ok(lines) => lines,
            Err(_) => continue, // Skip if we can't read the file
        };

        append_script(
            entry.file_name().to_str().unwrap(),
            &mut result_script,
            &lines,
        );
    }

    let file_path = "zsh/generated_init.zsh";
    let mut file = File::create(file_path).map_err(Error::IOError)?;

    for line in &result_script {
        writeln!(file, "{}", line).map_err(Error::IOError)?;
    }

    Ok(())
}
