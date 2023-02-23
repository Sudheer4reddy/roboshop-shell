source common.sh

print_head "Setup MongoDB Repository"
cp Configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "installing MongoDB"
yum install mongodb-org -y

print_head "Enable MongoDB"
systemctl enable mongod

print_head "starting MongoDB service"
systemctl start mongod


#update  /etc/mongod.conf from 127.0.0.1 to 0.0.0.0