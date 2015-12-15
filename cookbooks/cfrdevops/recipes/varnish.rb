execute "backing up default.vcl" do
  command "mv /etc/varnish/default.vcl /etc/varnish/default.vcl.original"
end

execute "changing varnish listening port" do
  command 'replace "VARNISH_LISTEN_PORT=6081" "VARNISH_LISTEN_PORT=80" -- /etc/sysconfig/varnish'
end

cookbook_file "/etc/varnish/default.vcl" do
  source "default.vcl"
end

execute "setting varnish service to start" do
  command 'chkconfig varnish on'
end

service "varnish" do
        action [:start]
end

