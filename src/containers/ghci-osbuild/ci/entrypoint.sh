#!/bin/bash

set -e

# OSBuild still needs loop-control access, as well as access to the individual
# loop-devices. We could, in the future, just create loop-control in the
# container and create the loop-devices manually. However, that is not how the
# code currently works.
mount -t devtmpfs none /dev

# Upstream docker now has `--cgroupns private` which should have the same
# effect as this `unshare`. However, older docker versions lack this argument,
# hence we simply run through `unshare -C`.
exec unshare -C -- "$@"
