use clap::{Parser, Subcommand};

mod cmds;
pub mod error;
pub mod utils;

#[derive(Parser)]
#[command(version, about)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    BuildInit,
    InstallPkgs,
    Scaffold {
        #[clap(index = 1, help = "Name of the package")]
        name: String,
    },
}

fn main() {
    let args = Cli::parse();

    if let Err(e) = match args.command {
        Commands::BuildInit => cmds::build_init::run(),
        Commands::InstallPkgs => cmds::install_pkgs::run(),
        Commands::Scaffold { name } => cmds::scaffold::run(&name),
    } {
        eprintln!("Error: {}", e);
        std::process::exit(1);
    }
}
