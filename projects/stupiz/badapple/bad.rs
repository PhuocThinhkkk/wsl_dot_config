use std::{fs, thread, time, io::{self, Write}};

fn play_txt_clip(folder: &str, fps: u32) -> io::Result<()> {
    let mut entries: Vec<_> = fs::read_dir(folder)?
        .filter_map(|entry| entry.ok())
        .collect();

    entries.sort_by(|a, b| {
        let a_name = a.file_name().to_string_lossy().into_owned();
        let b_name = b.file_name().to_string_lossy().into_owned();
        a_name.cmp(&b_name)
    });

    let mut frames = Vec::new();
    for entry in entries {
        let path = entry.path();
        if path.extension().and_then(|s| s.to_str()) == Some("txt") {
            let content = fs::read_to_string(path)?;
            frames.push(content);
        }
    }

    let delay = time::Duration::from_secs_f64(1.0 / fps as f64);

    for frame in frames {
        if cfg!(target_os = "windows") {
            std::process::Command::new("cls").status().ok();
        } else {
            print!("\x1B[2J\x1B[1;1H"); // ANSI escape code to clear
        }
        print!("{}", frame);
        io::stdout().flush().unwrap();
        thread::sleep(delay);
    }

    Ok(())
}

fn main() -> io::Result<()> {
    play_txt_clip("ascii-frames", 40)
}

