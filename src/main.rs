use std::fs;

use clap::{Parser, Subcommand};

#[derive(Debug, Parser)]
#[command(version, about, long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: CliCommand,
}

#[derive(Debug, Subcommand)]
enum CliCommand {
    Init,
}

fn main() {
    let cli = Cli::parse();

    match cli.command {
        CliCommand::Init => {
            fs::create_dir(".git").unwrap();
            fs::create_dir(".git/objects").unwrap();
            fs::create_dir(".git/refs").unwrap();
            fs::write(".git/HEAD", "ref: refs/heads/main\n").unwrap();

            let mut cwd = std::env::current_dir().unwrap();
            cwd.push(".git");
            println!("Initialized empty Git repository in {}", cwd.display());
        }
    }
}
