# nginx

##Installing nginx on RHEL 

**sudo yum update**

**sudo vi /etc/yum.repos.d/nginx.repo**

    [nginx]
    name=nginx repo
    baseurl=http://nginx.org/packages/rhel/7/$basearch/
    gpgcheck=0
    enabled=1

Replace 7 with 5 or 6 based on version of RHEL

**sudo yum install nginx.x86_64**

**sudo vi /etc/nginx/conf.d/default.conf**

**sudo service nginx start**

For more details around nginx installations http://www.rackspace.com/knowledge_center/article/nginx-basics-install-nginx-on-red-hat-enterprise-linux-and-debian-based-oss was a very useful link 

