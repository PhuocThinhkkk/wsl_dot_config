#!/bin/bash

INPUT_DIR="frames"
OUTPUT_DIR="ascii-frames"
mkdir -p "$INPUT_DIR" "$OUTPUT_DIR"
rm -f "$INPUT_DIR"/* "$OUTPUT_DIR"/*

echo "🎬 Extracting frames from badapple.mp4..."
ffmpeg -i badapple.mp4 -vf fps=30 "$INPUT_DIR/out%04d.jpg"

echo "🎨 Converting frames to ASCII..."
for file in "$INPUT_DIR"/*; do
    filename=$(basename "${file%.*}")
    ascii-image-converter "$file" > "$OUTPUT_DIR/$filename.txt"
done

echo "✅ Done! Frames ascii saved in $OUTPUT_DIR/"

