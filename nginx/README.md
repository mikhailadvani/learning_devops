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

###References

For more details around nginx installations http://www.rackspace.com/knowledge_center/article/nginx-basics-install-nginx-on-red-hat-enterprise-linux-and-debian-based-oss was a very useful link
 
Basic how to's of nginx configs at http://nginx.org/en/docs/beginners_guide.html

##Next steps

###Setup nginx on a node

See route /static/ in <a href="https://github.com/mikhailadvani/learning_devops/blob/master/nginx/web/default.conf">web/default.conf</a>

See route /app-static/ in <a href="https://github.com/mikhailadvani/learning_devops/blob/master/nginx/app/default.conf">app/default.conf</a>

####Proxy Pass an nginx route on the web layer node to app layer node. The app layer node will then be blocked using some security mechanism(not sure of the term yet)

See route /app-static/ in web/default.conf
The IP will be the elastic IP assigned to the lower layer node
