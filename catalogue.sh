source common.sh

print_head "Configure NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "Install NodeJS"
yum install nodejs -y &>>${log_file}

print_head "Create Roboshop User"
useradd roboshop &>>${log_file}

print_head "Create Application Directory"
mkdir /app &>>${log_file}

print_head "Delete Old Content"
rm -rf /app/* &>>${log_file}

print_head "Downloading Application Content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app &>>${log_file}

print_head "Extracting Application Content"
unzip /tmp/catalogue.zip &>>${log_file}

print_head "Installing NodeJS Dependencies "
npm install &>>${log_file} &>>${log_file}

print_head "Copy SystemD Service File"
cp Configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head "Reload SystemD"
systemctl daemon-reload &>>${log_file}

print_head "Enable Catalogue Service"
systemctl enable catalogue &>>${log_file}

print_head "Start Catalogue Service"
systemctl start catalogue &>>${log_file}

print_head "Copy MongoDB Repo File"
cp Configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

print_head "Install MongoDB Client"
yum install mongodb-org-shell -y &>>${log_file}

print_head "Load Schema"
mongo --host mongodb.roboshop.internal </app/schema/catalogue.js &>>${log_file}
