execute "backing up original httpd file" do
  command "cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.original"
end

execute "changing listening port" do
  command 'replace "Listen 80" "Listen 8080" -- /etc/httpd/conf/httpd.conf'
end

execute "adding vhost include" do
  command 'echo "Include conf/devops-test.conf" >> /etc/httpd/conf/httpd.conf'
end

execute "adding httpd service" do
  command 'chkconfig httpd on'
end

service "httpd" do
        action [:restart]
end
