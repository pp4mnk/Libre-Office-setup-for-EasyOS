#!/bin/sh
# LibreOffice Word-like Font Setup for EasyOS
# by pp4mnk

FONTDIR="/usr/share/fonts/truetype/pp4mnk-lo-compat"
TMPDIR="/tmp/pp4mnk-lo-fonts"
GUIDE="$HOME/LibreOffice-Word-like-setup-by-pp4mnk.txt"

echo "=============================================="
echo " LibreOffice Word-like Setup for EasyOS"
echo " by pp4mnk"
echo "=============================================="

mkdir -p "$FONTDIR"
rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"

download_font() {
    URL="$1"
    FILE="$2"

    echo "Downloading $FILE..."

    if command -v wget >/dev/null 2>&1; then
        wget -O "$TMPDIR/$FILE" "$URL" || echo "FAILED: $FILE"
    elif command -v curl >/dev/null 2>&1; then
        curl -L -o "$TMPDIR/$FILE" "$URL" || echo "FAILED: $FILE"
    else
        echo "ERROR: wget or curl is required."
        exit 1
    fi
}

BASE="https://raw.githubusercontent.com/ONLYOFFICE/core-fonts/master/crosextra"

download_font "$BASE/Carlito-Regular.ttf" "Carlito-Regular.ttf"
download_font "$BASE/Carlito-Bold.ttf" "Carlito-Bold.ttf"
download_font "$BASE/Carlito-Italic.ttf" "Carlito-Italic.ttf"
download_font "$BASE/Carlito-BoldItalic.ttf" "Carlito-BoldItalic.ttf"

download_font "$BASE/Caladea-Regular.ttf" "Caladea-Regular.ttf"
download_font "$BASE/Caladea-Bold.ttf" "Caladea-Bold.ttf"
download_font "$BASE/Caladea-Italic.ttf" "Caladea-Italic.ttf"
download_font "$BASE/Caladea-BoldItalic.ttf" "Caladea-BoldItalic.ttf"

echo ""
echo "Installing downloaded fonts..."
cp -v "$TMPDIR"/*.ttf "$FONTDIR/" 2>/dev/null

echo ""
echo "Refreshing font cache..."
fc-cache -fv

echo ""
echo "Checking fonts..."
fc-match Carlito
fc-match Caladea
fc-match "Liberation Sans"
fc-match "Liberation Serif"
fc-match "Liberation Mono"

cat > "$GUIDE" << 'EOF'
LibreOffice Word-like setup for EasyOS
by pp4mnk

Open LibreOffice Writer:

Tools > Options > LibreOffice > Fonts

Tick:

Apply replacement table

Add these replacements:

Calibri          -> Carlito
Cambria          -> Caladea
Arial            -> Liberation Sans
Times New Roman  -> Liberation Serif
Courier New      -> Liberation Mono

If available, tick "Always".

Then go to:

Tools > Options > Load/Save > General

Recommended:

Document type: Text document
Always save as: Word 2007-365 (*.docx)

Writer page style:

Format > Page Style

A4 paper
Margins: 2.5 cm on all sides

Default text style:

Font: Carlito
Size: 11 pt
Line spacing: 1.15

Close LibreOffice completely and reopen it.
EOF

rm -rf "$TMPDIR"

echo ""
echo "DONE."
echo "Guide created at:"
echo "$GUIDE"