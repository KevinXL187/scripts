#!/usr/bin/env bash
#
# list_all_apps.sh –  a one‑stop “installed applications” reporter
#
# Usage:
#   ./list_all_apps.sh > installed_apps.txt
#
# It will create/overwrite `installed_apps.txt` in the directory you run it from.

OUTPUT="installed_apps.txt"

# Helper: print a section header
print_section() {
    printf "\n==== %s ====\n\n" "$1" >> "$OUTPUT"
}

# 1. Fedora (dnf) packages
print_section "Fedora – DNF installed packages"
dnf list installed >> "$OUTPUT" 2>/dev/null
# (fallback in case dnf is not available)
# rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}\n' >> "$OUTPUT"

# 2. RPM packages (raw list – may duplicate the dnf list)
print_section "RPM (rpm -qa) – all packages"
rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}\n' >> "$OUTPUT"

# 3. Flatpak applications
if command -v flatpak >/dev/null 2>&1; then
    print_section "Flatpak applications"
    flatpak list --app >> "$OUTPUT"
else
    echo "Flatpak not installed" >> "$OUTPUT"
fi

# 4. Snap packages
if command -v snap >/dev/null 2>&1; then
    print_section "Snap packages"
    snap list >> "$OUTPUT"
else
    echo "Snap not installed" >> "$OUTPUT"
fi

# 5. Python pip packages (global and user)
print_section "Python (pip3) packages"
if command -v pip3 >/dev/null 2>&1; then
    pip3 list >> "$OUTPUT"
else
    echo "pip3 not found" >> "$OUTPUT"
fi

# 6. Node.js npm global packages
print_section "Node.js (npm global) packages"
if command -v npm >/dev/null 2>&1; then
    npm list -g --depth=0 >> "$OUTPUT"
else
    echo "npm not found" >> "$OUTPUT"
fi

# 7. Ruby gems (global & user)
print_section "Ruby gems"
if command -v gem >/dev/null 2>&1; then
    gem list >> "$OUTPUT"
else
    echo "gem not found" >> "$OUTPUT"
fi

# 8. Go binaries (if GOPATH set)
print_section "Go binaries (GOPATH/bin)"
if [ -n "$GOPATH" ]; then
    find "$GOPATH/bin" -maxdepth 1 -type f -executable >> "$OUTPUT"
else
    echo "GOPATH not set – skip" >> "$OUTPUT"
fi

# 9. Manually installed binaries in /usr/local/bin
print_section "/usr/local/bin binaries"
ls -1 /usr/local/bin >> "$OUTPUT"

# 10. Personal bin directory
print_section "Home bin directory (~/.local/bin or ~/bin)"
for d in ~/bin ~/.local/bin; do
    if [ -d "$d" ]; then
        ls -1 "$d" >> "$OUTPUT"
    fi
done

# 11. Git repositories under your home directory (cloned from GitHub or elsewhere)
print_section "Git repositories (roots of .git directories)"
# Grab the repo root path
find ~ -type d -name ".git" -maxdepth 4 -printf '%h\n' | sort -u >> "$OUTPUT"
# If you want the remote URL, uncomment the block below
# find ~ -type d -name ".git" -maxdepth 4 -exec sh -c '
#     repo=$(dirname "$1")
#     url=$(git -C "$repo" remote get-url origin 2>/dev/null)
#     echo "$repo -> $url"
# ' sh {} \; >> "$OUTPUT"

# 12. AppImages in /opt and in your home (optional)
print_section "AppImages in /opt and ~/"
find /opt -maxdepth 1 -type f -name '*.AppImage' -printf '%f\n' >> "$OUTPUT"
find ~ -maxdepth 2 -type f -name '*.AppImage' -printf '%f\n' >> "$OUTPUT"

# 13. Final marker
print_section "End of list"
printf "Report generated at %s\n" "$(date)" >> "$OUTPUT"