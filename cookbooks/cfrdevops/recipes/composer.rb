execute "downloading composer" do
  command 'curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer'
end

execute "linking composer for global use" do
  command 'ln -s /usr/local/bin/composer /usr/bin/composer'
end

