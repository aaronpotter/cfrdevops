execute "setting php memory limit" do
  command 'replace "memory_limit = 128M" "memory_limit = 256M" -- /etc/php.ini'
end

execute "setting php timezone" do
  command 'replace ";date.timezone =" "date.timezone = America/New_York" -- /etc/php.ini'
end

