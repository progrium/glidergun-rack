init() {
  cmd-export-ns rack "Glidergun-rack namespace"
  cmd-export rack-generate
}

rack-generate() {
  declare desc="Generates glider index file"
  declare REPO=$1
  declare VERSION=$2

  : ${REPO:?}
  : ${VERSION:?}

  local NAME=${REPO##*/}
  local linuxUrl=https://github.com/${REPO}/releases/download/v${VERSION}/${VERSION}_linux_amd64.tar.gz
  local darwinUrl=https://github.com/${REPO}/releases/download/v${VERSION}/${VERSION}_darwin_amd64.zip
  
  local linuxHash=$(curl -Ls $linuxUrl | checksum md5)
  local darwinHash=$(curl -Ls $darwinUrl | checksum md5)

cat > index/$NAME <<EOF
latest linux_amd64 ${linuxUrl} ${linuxHash}
latest darwin_amd64 ${darwinUrl} ${darwinHash}

${VERSION} linux_amd64 ${linuxUrl} ${linuxHash}
${VERSION} darwin_amd64 ${darwinUrl} ${darwinHash}
EOF
}

