#!/bin/bash

is_gcloud_installed() {
  [ -x "${HOME}/.local/opt/google-cloud-sdk/bin/gcloud" ]
}
