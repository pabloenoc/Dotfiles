# Dotfiles

## keyd setup (MacBook Pro 2020 T2, Fedora 44)

keyd 2.6.0 — https://github.com/rvaiya/keyd
Installed from COPR: alternateved/keyd
hid_apple: no swaps (all 0), fnmode=3 (kernel default) — keyd does all remapping

## Files
- default.conf → /etc/keyd/default.conf  (all keyboards)
- k480.conf    → /etc/keyd/k480.conf     (Logitech K480, id 046d:b33d)

## What it does
- Caps Lock   → Control
- Left Cmd    → Control
- Left Ctrl   → Super
- Right Cmd   → Super
- K480 only: Right Alt → Super

Emacs `s-` bindings in init.el (s-c, s-v, s-s, etc.) rely on this.

## Restore
1. sudo dnf copr enable alternateved/keyd
2. sudo dnf install keyd
3. sudo cp default.conf k480.conf /etc/keyd/
4. sudo systemctl enable --now keyd
5. After any edit: sudo keyd reload

## Finding a new keyboard's id
sudo keyd monitor   (press keys; the id shows on each line)
