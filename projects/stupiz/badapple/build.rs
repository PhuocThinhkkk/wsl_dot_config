use std::{env, fs, path::Path, io::Write};

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();
    let dest_path = Path::new(&out_dir).join("frames.rs");
    let mut f = fs::File::create(&dest_path).unwrap();

    writeln!(f, "pub static FRAMES: &[&str] = &[").unwrap();

    let manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap(); // project root
    let mut entries: Vec<_> = fs::read_dir("ascii-frames")
        .unwrap()
        .filter_map(|e| e.ok())
        .collect();
    entries.sort_by_key(|e| e.file_name());

    for entry in entries {
        let path = entry.path();
        if path.extension().and_then(|s| s.to_str()) == Some("txt") {
            // absolute path
            let abs_path = Path::new(&manifest_dir).join(&path);
            writeln!(f, "    include_str!(\"{}\"),", abs_path.display()).unwrap();
        }
    }

    writeln!(f, "];").unwrap();
}

