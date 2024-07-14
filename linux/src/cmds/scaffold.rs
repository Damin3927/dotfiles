use std::{
    fs::{create_dir, File},
    io::Write,
    path::Path,
};

use crate::error::{Error, Result};

fn create_default_script(name: &str) -> Result<()> {
    let file_path = Path::new(name);
    let mut file = File::create(file_path).map_err(Error::IOError)?;

    file.write_all(b"#!/bin/bash\n\n").map_err(Error::IOError)?;

    Ok(())
}

pub fn run(name: &str) -> Result<()> {
    let dir_path = format!("init/{}", name);
    create_dir(&dir_path).map_err(Error::IOError)?;

    create_default_script(&format!("{}/init.sh", dir_path))?;
    create_default_script(&format!("{}/install.sh", dir_path))?;

    Ok(())
}
