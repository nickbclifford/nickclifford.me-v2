#!/bin/bash

eval "$(ssh-agent -s)"
chmod 600 .travis/id_rsa

git config --global push.default matching
git remote add deploy ssh://git@$IP:$PORT/$DEPLOY_DIR
git push deploy master

ssh apps@$IP -p $PORT << EOF
  cd $DEPLOY_DIR
  crystal build --release index.cr
EOF
