execute "downloading drush" do
  command 'curl -sS http://files.drush.org/drush.phar -o /tmp/drush.phar'
end

execute "check drush status" do
  command 'php /tmp/drush.phar core-status'
end

execute "setting permissions on drush" do
  command 'chmod +x /tmp/drush.phar'
end

execute "moving to local bin" do
  command 'mv /tmp/drush.phar /usr/local/bin/drush'
end

execute "linking to usr bin" do
  command 'ln -s /usr/local/bin/drush /usr/bin/drush'
end

execute "initializing drush" do
  command '/usr/bin/drush init'
end

