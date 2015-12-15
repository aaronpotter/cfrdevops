execute "adding mysqld service" do
  command 'chkconfig mysqld on'
end

service "mysqld" do
        action [:start]
end


script 'configure mysql users and passwords' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
  echo "127.0.0.1  vagrant-centos65.vagrantup.com devops-test.cfr.dev" >> /etc/hosts
  /usr/bin/mysqladmin -u root -h vagrant-centos65.vagrantup.com password 'cfrdevops'
  mysql -u root -pcfrdevops --execute="CREATE USER 'cfrtest'@'localhost' IDENTIFIED BY 'cfrtest';"
  EOH
end
