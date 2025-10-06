use std::{env, fs, io::Write, path::Path};

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();

    let dest_path = Path::new(&out_dir).join("frames.rs");
    let mut f = fs::File::create(&dest_path).unwrap();

    writeln!(f, "pub static FRAMES: &[&str] = &[").unwrap();

    let mut entries: Vec<_> = fs::read_dir("ascii-frames")
        .unwrap()
        .filter_map(|e| e.ok())
        .collect();
    entries.sort_by_key(|e| e.file_name());

    for entry in entries {
        let path = entry.path();
        if path.extension().and_then(|s| s.to_str()) == Some("txt") {
            let abs_path = fs::canonicalize(&path).unwrap();
            writeln!(
                f,
                "    include_str!(r\"{}\"),",
                abs_path.display()
            ).unwrap();
        }
    }

    writeln!(f, "];").unwrap();

    let audio_dest = Path::new(&out_dir).join("audio.rs");
    let mut a = fs::File::create(&audio_dest).unwrap();

    let abs_audio = fs::canonicalize("badapple.mp3").unwrap();
    writeln!(
        a,
        "pub static AUDIO: &[u8] = include_bytes!(r\"{}\");",
        abs_audio.display()
    ).unwrap();
}

