mod frames {
    include!(concat!(env!("OUT_DIR"), "/frames.rs"));
}

mod audio {
    include!(concat!(env!("OUT_DIR"), "/audio.rs"));
}

use std::{
    fs::File,
    io,
    io::Write,
    process::{Command, Stdio},
    thread,
    time::{Duration, Instant},
};

fn main() {
    let tmp_path = std::env::temp_dir().join("badapple.mp3");
    let mut f = File::create(&tmp_path).unwrap();
    f.write_all(audio::AUDIO).unwrap();

    let mut child = Command::new("ffplay.exe")
        .args(&[
            tmp_path.to_str().unwrap(),
            "-autoexit",
            "-loglevel",
            "quiet",
            "-nodisp",
        ])
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .spawn()
        .expect("failed to start ffplay");

    let fps = 40.0;

    let start = Instant::now();
    for (i, frame) in frames::FRAMES.iter().enumerate() {
        let target_time = Duration::from_secs_f64(i as f64 / fps);
        while Instant::now() - start < target_time {
            thread::sleep(Duration::from_millis(1));
        }

        print!("\x1B[2J\x1B[1;1H");
        print!("{}", frame);
        io::stdout().flush().unwrap();
    }
    let _ = child.wait();
}
