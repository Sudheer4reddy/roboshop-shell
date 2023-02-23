source common.sh

print_head "Setup MongoDB Repository"
cp ${code_dir}/Configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
status_check $?

print_head "installing MongoDB"
yum install mongodb-org -y &>>${log_file}
status_check $?

print_head "Update MongoDB Listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}
status_check $?

print_head "Enable MongoDB"
systemctl enable mongod &>>${log_file}
status_check $?

print_head "starting MongoDB service"
systemctl restart mongod &>>${log_file}
status_check $?

