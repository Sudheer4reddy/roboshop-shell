source common.sh

if [ -z "${1}" ]; then
  echo "Missing MySQL Root Password argument"
  exit 1
fi
print_head "Disabling MySQL 8 Version"
dnf module disable mysql -y
status_check $?

print_head "Installing MySQL Server"
yum install mysql-community-server -y
status_check $?

print_head "Enable MySQL Service"
systemctl enable mysqld
status_check $?

print_head "Start MySQL Service"
systemctl start mysqld
status_check $?

print_head "Set Root Password"
mysql_secure_installation --set-root-pass RoboShop@1
status_check $?