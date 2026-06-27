#!/bin/sh
# LibreOffice compatibility fonts for EasyOS
# by pp4mnk

set -e

FONTDIR="/usr/share/fonts/truetype/pp4mnk-lo-compat"
TMPDIR="/tmp/pp4mnk-lo-fonts"

echo "LibreOffice EasyOS compatibility font installer"
echo "by pp4mnk"
echo "---------------------------------------------"

mkdir -p "$FONTDIR"
rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"

cd "$TMPDIR"

echo "Downloading Carlito..."
wget -O carlito.zip https://github.com/googlefonts/carlito/archive/refs/heads/main.zip

echo "Downloading Caladea..."
wget -O caladea.zip https://github.com/googlefonts/caladea/archive/refs/heads/main.zip

echo "Extracting fonts..."
unzip -q carlito.zip
unzip -q caladea.zip

echo "Installing Carlito and Caladea..."
find "$TMPDIR" -iname "*.ttf" -exec cp -v {} "$FONTDIR/" \;

echo "Checking for Liberation fonts..."
if fc-match "Liberation Sans" | grep -qi "Liberation"; then
    echo "Liberation fonts already installed."
else
    echo "WARNING: Liberation fonts do not seem to be installed."
    echo "Please install them from PKGget if available."
fi

echo "Refreshing font cache..."
fc-cache -fv

echo ""
echo "Installed fonts check:"
fc-match Carlito
fc-match Caladea
fc-match "Liberation Sans"
fc-match "Liberation Serif"
fc-match "Liberation Mono"

echo ""
echo "Recommended LibreOffice replacements:"
echo "Calibri          -> Carlito"
echo "Cambria          -> Caladea"
echo "Arial            -> Liberation Sans"
echo "Times New Roman  -> Liberation Serif"
echo "Courier New      -> Liberation Mono"

echo ""
echo "Now open LibreOffice Writer:"
echo "Tools > Options > LibreOffice > Fonts"
echo "Tick: Apply replacement table"
echo "Add the replacements above."
echo ""
echo "Done. Please restart LibreOffice completely."