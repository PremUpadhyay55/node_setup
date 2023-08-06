echo "Installing NGINX"
sudo apt-get update
sudo apt-get install nginx -y
sudo rm /etc/nginx/sites-available/*
sudo rm /etc/nginx/sites-enabled/*
sudo cp ~/node_setup/nms.cfg /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/nms.cfg /etc/nginx/sites-enabled/
sudo systemctl start nginx
echo "Installing docker and docker compose"
sudo apt-get update
sudo apt-get install docker.io -y
sudo apt-get install docker-compose -y
echo "First Checking Pipe and starting"
nohup ./pipe_listener.sh &
echo "Starting the NMS Docker "
sudo docker-compose up -d
sudo cp -rp /home/ubuntu/nms_project/node_mgmt_system/nms_app/static/ /app/
sudo chown -R www-data:www-data /app
sudo systemctl restart nginx
echo "All done"
