execute "enable webtatic repo" do
  command "rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm"
end

cookbook_file "/etc/yum.repos.d/elasticsearch.repo" do
  source "elasticsearch.repo"
end
