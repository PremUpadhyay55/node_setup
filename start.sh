IP=$(curl -s ifconfig.me)
echo "Installing NGINX"
sudo apt-get update
sudo apt-get install nginx -y
sudo rm /etc/nginx/sites-available/*
sudo rm /etc/nginx/sites-enabled/*
sed -i -e 's/localhost/'$IP'/g' nms.cfg
sudo cp ./nms.cfg /etc/nginx/sites-available/
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
while true
do
   if [ -d /home/ubuntu/nms_project/node_mgmt_system/nms_app/static ] ;
   then
      echo "Almost done.."
      break
   else
     echo "just few more moments ...."
     sleep 2
    fi
done
sleep 10
sudo mkdir /nms_app
sudo cp -rp /home/ubuntu/nms_project/node_mgmt_system/nms_app/static/ /nms_app/
sudo chown -R www-data:www-data /nms_app
sudo systemctl restart nginx

IP_ADDR=$(wget -qO- ifconfig.me) 
echo "### Node Setup Completed  ##"
echo " "
echo " Please note down below details"
echo " ------ ---- ---- ----- -------"
echo " "
echo " You node IP Address: $IP_ADDR"
URL="http://$IP_ADDR:8000/nms_app/get_node_id/"
NODE_ID=$(curl  -s -X 'POST' \
  $URL \
  -H 'accept: application/json' \
  -H 'authorization: AR12532DE@#GH&67GF24GH45532$##FGG' \
  -d '')
  NODE_ID=$(echo "$NODE_ID" | cut -d ":" -f 3 | sed 's/.$//')
echo " Your Node id Is:  $NODE_ID "
