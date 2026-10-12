# Contact-sheet photos

Drop photos in here named `photo-1` to `photo-6` (any format: JPG, PNG, HEIC…), then run:

```
photos/convert.sh            # convert everything to web-sized .webp
photos/convert.sh 2:90       # …and rotate photo-2 90° clockwise (270 = counter-clockwise)
```

It shrinks each one to 1400 px on the long side, saves `photo-N.webp`, and moves the original to `~/Pictures/itsbenduncan-originals` so the full-size file never ends up in git. Then commit and push.

| File | Frame |
| --- | --- |
| photo-1 | top strip, left (the circled "keeper!") |
| photo-2 | top strip, middle |
| photo-3 | top strip, right |
| photo-4 | bottom strip, left |
| photo-5 | bottom strip, middle (the one with the red X) |
| photo-6 | bottom strip, right |

- Frames are 3:2 landscape and crop to fill, centred.
- Any frame without a photo keeps its drawn stand-in.
- The page looks for `.webp` first, then `.jpg`, `.jpeg`, `.png`. Extensions must be lowercase (GitHub Pages is case-sensitive), which the script handles for you.
