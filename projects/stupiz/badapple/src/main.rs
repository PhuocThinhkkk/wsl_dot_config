mod frames {
    include!(concat!(env!("OUT_DIR"), "/frames.rs"));
}

use std::{thread, time, io::{self, Write}};

fn main() {
    let fps = 48; // or get from command line
    let delay = time::Duration::from_secs_f64(1.0 / fps as f64);

    for frame in frames::FRAMES {
        print!("\x1B[2J\x1B[1;1H"); // clear screen
        print!("{}", frame);
        io::stdout().flush().unwrap();
        thread::sleep(delay);
    }
}

