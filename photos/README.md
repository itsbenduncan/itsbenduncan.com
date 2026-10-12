# Contact-sheet photos

Drop photos in here with these names (any format: JPG, PNG, HEIC…), then run `photos/convert.sh`.

| Name | Where it goes | Shape |
| --- | --- | --- |
| `photo-1` … `photo-3` | top 35mm strip, left to right (1 gets the "keeper!" circle) | 3:2 landscape |
| `photo-4` … `photo-6` | middle 35mm strip (5 gets the red X) | 3:2 landscape |
| `pano` | the 120 strip, split across three square frames | 3:1 (e.g. 3240×1080) |
| `sheet-1`, `sheet-2` | the two loose 4×5 prints | 4:5 portrait (e.g. 1080×1350) |

```
photos/convert.sh              # convert everything to web-sized .webp
photos/convert.sh 2:90         # …and rotate photo-2 90° clockwise (270 = counter-clockwise)
photos/convert.sh sheet-1:90   # same for a sheet
```

The script shrinks each photo to at most 1400 px on the long side (2400 for `pano`), saves it as `name.webp`, and moves the original to `~/Pictures/itsbenduncan-originals`, so full-size files never end up in git. Then commit and push.

- Anything that isn't the right shape gets cropped to fill, centred. A pano wider than 3:1 leaves gaps top and bottom, so crop it to 3:1 first.
- Any slot without a photo keeps its drawn stand-in.
- The page looks for `.webp` first, then `.jpg`, `.jpeg`, `.png`. Extensions must be lowercase (GitHub Pages is case-sensitive), which the script handles for you.

