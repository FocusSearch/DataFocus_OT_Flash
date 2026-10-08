#!/usr/bin/env bash
# Download the immutable r53 archive directly, with resumable transfers.
set -euo pipefail

BASE='https://github.com/FocusSearch/DataFocus_OT_Flash/releases/download/v0.1.0-test-r53'
ARCHIVE='OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz'
ARCHIVE_SHA='e045423b2744e0f28c3f46b649aa20724ea8d79686d5d96e8ed7c48b4e699abd'
ARCHIVE_BYTES=7191482492

die() { printf 'Error: %s\n' "$*" >&2; exit 1; }
if [[ ${1:-} == --help || ${1:-} == -h ]]; then
    printf 'Usage: bash download-r53.sh [output-directory]\nRequires curl, and sha256sum or shasum. Allow at least 15 GiB free.\n'
    exit 0
fi
[[ $# -le 1 ]] || die 'Use --help for usage.'
command -v curl >/dev/null || die 'curl is required.'
if command -v sha256sum >/dev/null; then
    sha_value() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null; then
    sha_value() { shasum -a 256 "$1" | awk '{print $1}'; }
else
    die 'sha256sum or shasum is required.'
fi
file_bytes() { wc -c < "$1" | tr -d '[:space:]'; }
matches() { [[ -f $1 && ! -L $1 ]] && [[ $(file_bytes "$1") == "$2" ]] && [[ $(sha_value "$1") == "$3" ]]; }

mkdir -p -- "${1:-.}"
cd -- "${1:-.}"
if [[ -e $ARCHIVE || -L $ARCHIVE ]]; then
    matches "$ARCHIVE" "$ARCHIVE_BYTES" "$ARCHIVE_SHA" || die "Existing $ARCHIVE is invalid; move it aside before retrying."
    printf 'Already verified: %s\n' "$PWD/$ARCHIVE"
    exit 0
fi

while read -r suffix bytes digest; do
    part="$ARCHIVE.part-$suffix"
    if [[ -e $part || -L $part ]]; then
        matches "$part" "$bytes" "$digest" || die "Existing $part is invalid; move it aside before retrying."
        printf 'Verified existing part: %s\n' "$part"
        continue
    fi
    partial="$part.downloading"
    [[ ! -L $partial ]] || die "Refusing symbolic link: $partial"
    if [[ -e $partial ]]; then
        [[ -f $partial ]] || die "Not a regular file: $partial"
        if matches "$partial" "$bytes" "$digest"; then
            mv -- "$partial" "$part"
            continue
        fi
        [[ $(file_bytes "$partial") -lt $bytes ]] || die "Invalid completed transfer: $partial; move it aside before retrying."
    fi
    printf 'Downloading %s (direct connection, resume enabled)...\n' "$part"
    curl --noproxy '*' --proxy '' --fail --location \
        --proto '=https' --proto-redir '=https' \
        --connect-timeout 30 --retry 3 --retry-delay 3 \
        --continue-at - --output "$partial" "$BASE/$part"
    matches "$partial" "$bytes" "$digest" || die "Checksum failed: $partial; move it aside before retrying."
    mv -- "$partial" "$part"
    printf 'Verified: %s\n' "$part"
done <<'PARTS'
01 1992294400 8b5120550197e2e48f3c1a135d7cf64f471c2041699a18519e5af64735201e28
02 1992294400 c8f305f6596815a78f8503f2ad3191939f16a44da8d39246a6a238a58d3f528f
03 1992294400 4689fb0f8a869e07f9ae330aef1f34fd9201cfc04abf6caf9d606bcf52830110
04 1214599292 51c9d9ff36accbc74c69636c9f995da3cdd4389ff00d0d0cacd99af0cd061936
PARTS

temporary=$(mktemp "./$ARCHIVE.assembling.XXXXXX")
trap 'rm -f -- "$temporary"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
printf 'Assembling the original archive...\n'
cat -- "$ARCHIVE.part-01" "$ARCHIVE.part-02" "$ARCHIVE.part-03" "$ARCHIVE.part-04" > "$temporary"
matches "$temporary" "$ARCHIVE_BYTES" "$ARCHIVE_SHA" || die 'Whole archive checksum failed.'
[[ ! -e $ARCHIVE && ! -L $ARCHIVE ]] || die 'Archive appeared during assembly; refusing to replace it.'
mv -- "$temporary" "$ARCHIVE"
trap - EXIT
printf '\nVerified archive: %s\nSHA-256: %s\nParts retained for recovery. Installation: docs/INSTALL.md in the release repository.\n' "$PWD/$ARCHIVE" "$ARCHIVE_SHA"
