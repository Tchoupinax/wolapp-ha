ssh ha "mkdir -p /tmp/wolapp"
scp -O Dockerfile config.yaml build.yaml ha:/tmp/wolapp

ssh ha "sudo mkdir -p /addons/wolapp"
ssh ha "sudo cp /tmp/wolapp/* /addons/wolapp"
