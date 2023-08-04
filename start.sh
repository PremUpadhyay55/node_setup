echo "Installing NGINX"
sudo apt-get update
sudo apt-get install nginx -y
sudo rm /etc/nginx/sites-available/*
sudo cp ~/nms/nms.cfg /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/nms.cfg /etc/nginx/sites-enabled/
sudo systemctl start nginx
echo "First Checking Pipe and starting"
nohup ./pipe_listener.sh &
echo "Starting the NMS Docker "
docker-compose up -d
echo "All done"
