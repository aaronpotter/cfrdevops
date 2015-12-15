package ['mysql', 'mysql-server', 'httpd', 'varnish'] do 
	action :install
end	

package ['php55w', 'php55w', 'php55w-pecl-imagick', 'php55w-pecl-memcache', 'memcached'] do 
	action :install
end

package ['java-1.7.0-openjdk', 'elasticsearch'] do 
	action :install
end	
