# Touch Bar setup (MacBook Pro 2020 T2, Fedora 44)

Touch Bar is drawn by tiny-dfr (comes with t2linux Fedora).

## Files
- config.toml → /etc/tiny-dfr/config.toml
  MediaLayerDefault = true — show brightness/media by default.
  Needed because keyd intercepts fn, so fn can't toggle layers.
- tiny-dfr-suspend.service → /etc/systemd/system/tiny-dfr-suspend.service
  Stops tiny-dfr before sleep and starts it fresh on resume.
  Without it, the Touch Bar stays blank after waking.

## Restore
1. sudo mkdir -p /etc/tiny-dfr
2. sudo cp config.toml /etc/tiny-dfr/
3. sudo cp tiny-dfr-suspend.service /etc/systemd/system/
4. sudo systemctl daemon-reload
5. sudo systemctl enable tiny-dfr-suspend.service
6. sudo systemctl restart tiny-dfr

## If the Touch Bar is blank
sudo systemctl start tiny-dfr
