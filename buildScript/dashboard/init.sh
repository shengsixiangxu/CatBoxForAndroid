#!/bin/bash

# Just support MetaCubexd :)
# Now you can use metacubexd or Yacd-meta
DASH_REPO="$1"
DIST_DIR="Dash-${DASH_REPO}"

pnpm -v || exit 1

pushd ..


if [ ! -d "$DASH_REPO" ]; then
  git clone https://github.com/MetaCubeX/${DASH_REPO}.git
fi

pushd ${DASH_REPO}/
  git pull https://github.com/MetaCubeX/${DASH_REPO}.git
  mkdir -p $DIST_DIR
  pnpm install
  pnpm build --outDir $DIST_DIR || exit 1

  zip -r dashboard.zip $DIST_DIR -9
popd

popd

cp ../${DASH_REPO}/dashboard.zip app/src/main/assets/dashboard.zip
echo ">> install $DASH_REPO to  app/src/main/assets/dashboard.zip"