# OBS MKV Joiner

OBS MKV Joiner is a simple desktop application for Linux built with Ruby and GTK4. It allows users to merge multiple `.mkv` video files, such as recordings created with OBS Studio, into a single video using FFmpeg. The application uses FFmpeg directly from the system and merges videos without re-encoding, preserving the original quality while keeping the process fast and efficient.

## Requirements

Before running the application, make sure the following packages are installed:

### Fedora

```bash
sudo dnf install ruby ruby-devel gtk4-devel ffmpeg
```

Install the GTK4 Ruby gem:

```bash
gem install gtk4
```

If you encounter permission issues:

```bash
sudo gem install gtk4
```

## Running the Application

Navigate to the project folder and execute:

```bash
ruby OBSMKVJoiner.rb
```

## How to Use

1. Open the application.
2. Enter the path to the folder containing your `.mkv` recordings.
3. Click **"Unir Videos"**.
4. Wait for the process to complete.
5. The merged file will be created in the same folder as `video_final.mkv`.

## Notes

- All `.mkv` files found in the selected folder will be merged.
- FFmpeg must be installed and available in the system PATH.
- Videos are merged using FFmpeg's `-c copy` option, which means they are not re-encoded.
- For best results, all videos should have the same recording settings and codecs.

## License

MIT License
