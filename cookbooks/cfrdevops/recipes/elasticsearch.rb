execute "adding elasticsearch service" do
  command 'chkconfig --add elasticsearch'
end

service "elasticsearch" do
        action [:start]
end
