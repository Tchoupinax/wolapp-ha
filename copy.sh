ssh ha "mkdir -p /tmp/wolapp"
scp -O config.yaml ha:/tmp/wolapp
scp -O build.yaml ha:/tmp/wolapp

ssh ha "sudo mkdir -p /addons/wolapp"
ssh ha "sudo cp /tmp/wolapp/* /addons/wolapp"
