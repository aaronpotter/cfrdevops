script 'configure additional memcached daemons' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH

# memcached2 config
cp /etc/init.d/memcached /etc/init.d/memcached2 -fv
cp /etc/sysconfig/memcached /etc/sysconfig/memcached2 -fv
cp /var/run/memcached/memcached.pid cp /var/run/memcached/memcached2.pid
touch /var/lock/subsys/memcached2

replace "/etc/sysconfig/memcached" "/etc/sysconfig/memcached2" -- /etc/init.d/memcached2
replace "/var/run/memcached/memcached.pid" "/var/run/memcached/memcached2.pid" -- /etc/init.d/memcached2
replace "/var/lock/subsys/memcached2" "/var/lock/subsys/memcached2" -- /etc/init.d/memcached2

replace "11211" "11212" -- /etc/init.d/memcached2
replace "11211" "11212" -- /etc/sysconfig/memcached2

# memcache3 config
cp /etc/init.d/memcached /etc/init.d/memcached3 -fv
cp /etc/sysconfig/memcached /etc/sysconfig/memcached3 -fv
cp /var/run/memcached/memcached.pid cp /var/run/memcached/memcached3.pid
touch /var/lock/subsys/memcached3

replace "/etc/sysconfig/memcached" "/etc/sysconfig/memcached3" -- /etc/init.d/memcached3
replace "/var/run/memcached/memcached.pid" "/var/run/memcached/memcached3.pid" -- /etc/init.d/memcached3
replace "/var/lock/subsys/memcached" "/var/lock/subsys/memcached3" -- /etc/init.d/memcached3

replace "11211" "11213" -- /etc/init.d/memcached3
replace "11211" "11213" -- /etc/sysconfig/memcached3
  EOH
end

execute "chkconfig memcached on" do
  command 'chkconfig memcached on'
end

service "memcached" do
        action [:start]
end

execute "chkconfig memcached2 on" do
  command 'chkconfig memcached2 on'
end

service "memcached2" do
        action [:start]
end

service "memcached3" do
        action [:start]
end

execute "chkconfig memcached3 on" do
  command 'chkconfig memcached3 on'
end
