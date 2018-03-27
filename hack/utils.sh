#!/bin/bash

# gives cluster-admin on GKE clusters if auth'd
gimme-admin() {
  kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole cluster-admin --user $(gcloud config get-value account)
}

# sub GSUITE_EMAIL for an email address in an RBAC policy
replace-email() {
  local EMAIL=$1
  [[ -z "$1"  ]] && { echo "usage: replace-email <email-address>" >&2; return 1;  }
  find $(pwd) -type f -name "*.yaml" | xargs sed -i "s/TFLAB_GSUITE_EMAIL/${EMAIL}/g"
}

# quick function to fetch a fresh terraform binary
download-terraform() {
  local OS=linux
  local dir=$(pwd)

  # usage
  [[ -z "$1" ]] && { echo "usage: update-terraform <version>" >&2; return 1; }

  # switch out for macOS if we have to
  [ `uname -s` == "Darwin" ] && { OS=darwin; }

  wget -O /tmp/tf.zip https://releases.hashicorp.com/terraform/${1}/terraform_${1}_${OS}_amd64.zip && \
  unzip /tmp/tf.zip -d /tmp && \
  rm -v /tmp/tf.zip && \
  mv -v /tmp/terraform ${dir}
}

download-skaffold() {
  local OS=linux
  local dir=$(pwd)

  # usage
  [[ $1 =~ --?h(elp)?  ]] && { echo "usage: download-skaffold /path/to/download/to" >&2; return 1; }
  [[ ! -z $1 ]] && { dir=$1; }


  # switch out for macOS if we have to
  [ `uname -s` == "Darwin" ] && { OS=darwin; }

  wget -O ${dir}/skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-${OS}-amd64 && \
  chmod +x ${dir}/skaffold
}
