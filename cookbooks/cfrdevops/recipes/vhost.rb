directory '/var/www/sites/devops-test.cfr.dev' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

execute "adding index.html" do
  command 'echo "<html><body>CFR Devops Test</body></html>" >> /var/www/sites/devops-test.cfr.dev/index.html'
end

cookbook_file "/etc/httpd/conf/devops-test.conf" do
  source "devops-test.conf"
end
