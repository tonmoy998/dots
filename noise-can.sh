sudo apt install pulseaudio 
pulseaudio --start
sudo cp /etc/pulse/default.pa /etc/pulse/default.pa.bak
sudo cat <<EOT >> /etc/pulse/default.pa
load-module module-echo-cancel source_name=noechosource sink_name=noechosink
set-default-source noechosource
set-default-sink noechosink
EOT
