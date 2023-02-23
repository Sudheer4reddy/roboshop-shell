source common.sh

print_head "Configure NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
status_check $?

print_head "Install NodeJS"
yum install nodejs -y &>>${log_file}
status_check $?

print_head "Create Roboshop User"
useradd roboshop &>>${log_file}
status_check $?

print_head "Create Application Directory"
mkdir /app &>>${log_file}
status_check $?

print_head "Delete Old Content"
rm -rf /app/* &>>${log_file}
status_check $?

print_head "Downloading Application Content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app &>>${log_file}
status_check $?

print_head "Extracting Application Content"
unzip /tmp/catalogue.zip &>>${log_file}
status_check $?

print_head "Installing NodeJS Dependencies "
npm install &>>${log_file}
status_check $?

print_head "Copy SystemD Service File"
cp ${code_dir}/Configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}
status_check $?

print_head "Reload SystemD"
systemctl daemon-reload &>>${log_file}
status_check $?

print_head "Enable Catalogue Service"
systemctl enable catalogue &>>${log_file}
status_check $?

print_head "Start Catalogue Service"
systemctl start catalogue &>>${log_file}
status_check $?

print_head "Copy MongoDB Repo File"
cp ${code_dir}/Configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
status_check $?

print_head "Install MongoDB Client"
yum install mongodb-org-shell -y &>>${log_file}
status_check $?

print_head "Load Schema"
mongo --host mongodb.roboshop.internal </app/schema/catalogue.js &>>${log_file}
status_check $?
