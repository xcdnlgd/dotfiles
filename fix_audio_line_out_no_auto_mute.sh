#!/bin/bash
# Fix: 3.5mm headphone plug/unplug speaker pop on Lenovo ALC222 (Realtek)
# Keeps hardware Auto-Mute disabled (the pop source) and lets WirePlumber
# software-mute "Line Out" via ACP mixer paths instead.
# NOTE: [Element Line Out] must be added near the END of the path files
# (before .include), placement elsewhere causes problems (see AskUbuntu 1527106).
#
# NOTE: Keep Auto-Mute in alsamixer disabled. That is hardware Auto-Mute, which will cause audio pop.
set -euo pipefail

LO=/usr/share/alsa-card-profile/mixer/paths/analog-output-lineout.conf
HP=/usr/share/alsa-card-profile/mixer/paths/analog-output-headphones.conf

echo "== Backing up =="
[ -f "$LO.orig" ] || cp -a "$LO" "$LO.orig"
[ -f "$HP.orig" ] || cp -a "$HP" "$HP.orig"

echo "== Patching $LO =="
if grep -q '^\[Element Line Out\]' "$LO"; then
  echo "  already patched"
else
  sed -i '/^\.include analog-output.conf.common/i [Element Line Out]\nswitch = mute\nvolume = merge\noverride-map.1 = all\noverride-map.2 = all-left,all-right\n' "$LO"
  echo "  patched"
fi

echo "== Patching $HP =="
if grep -q '^\[Element Line Out\]' "$HP"; then
  echo "  already patched"
else
  sed -i '/^\.include analog-output.conf.common/i [Element Line Out]\nswitch = off\nvolume = off\n' "$HP"
  echo "  patched"
fi

echo "== Installing patcher script =="
cat > /usr/local/bin/audio-path-fix.sh <<'EOF'
#!/bin/bash
LO=/usr/share/alsa-card-profile/mixer/paths/analog-output-lineout.conf
HP=/usr/share/alsa-card-profile/mixer/paths/analog-output-headphones.conf
[ -f "$LO" ] || exit 0
[ -f "$HP" ] || exit 0
grep -q '^\[Element Line Out\]' "$LO" || sed -i '/^\.include analog-output.conf.common/i [Element Line Out]\nswitch = mute\nvolume = merge\noverride-map.1 = all\noverride-map.2 = all-left,all-right\n' "$LO"
grep -q '^\[Element Line Out\]' "$HP" || sed -i '/^\.include analog-output.conf.common/i [Element Line Out]\nswitch = off\nvolume = off\n' "$HP"
EOF
chmod +x /usr/local/bin/audio-path-fix.sh

echo "== Installing pacman hook =="
mkdir -p /etc/pacman.d/hooks
cat > /etc/pacman.d/hooks/audio-path-fix.hook <<'EOF'
[Trigger]
Operation = Install
Operation = Upgrade
Type = File
Target = usr/share/alsa-card-profile/mixer/paths/analog-output-lineout.conf
Target = usr/share/alsa-card-profile/mixer/paths/analog-output-headphones.conf

[Action]
Description = Reapplying Line Out auto-mute path fix...
When = PostTransaction
Exec = /usr/local/bin/audio-path-fix.sh
EOF

echo "== Done =="
