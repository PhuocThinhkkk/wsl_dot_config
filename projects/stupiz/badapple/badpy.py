import os, time

def play_txt_clip(folder, fps=30):
    txt_files = sorted([f for f in os.listdir(folder) if f.endswith(".txt")])
    frames = []

    for file in txt_files:
        with open(os.path.join(folder, file), "r", encoding="utf-8") as f:
            frames.append(f.read())

    delay = 1 / fps
    for frame in frames:
        os.system('cls' if os.name == 'nt' else 'clear')
        print(frame)
        time.sleep(delay)

play_txt_clip("ascii-frames", fps=40)

