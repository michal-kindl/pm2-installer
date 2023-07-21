@echo off
:: 1) create fresh production build
echo "= 1/3 |*  | Creating fresh bundle cache ="
call npm run bundle

:: 2) remove old bundle directory and create a new one
echo "= 2/3 |** | Recreating bundle directory ="
if exist offline-bundle rmdir offline-bundle /s /q
mkdir offline-bundle

:: 4) copy other install files
echo "= 3/3 |***| Copying additional files ="
xcopy src "offline-bundle/src" /E /H /I
copy *.gz offline-bundle
copy *.zip offline-bundle
copy package*.json offline-bundle
copy bundle.json offline-bundle
copy *.md offline-bundle
copy .npmrc offline-bundle

echo Bundle completed and stored to offline_bundle directory.
