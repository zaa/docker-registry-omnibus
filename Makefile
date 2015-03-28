all: clean rpm

rpm:
	sudo bundler exec fpm-cook

install:
	sudo yum install -y pkg/docker-registry-omnibus-*.rpm

clean:
	sudo bundler exec fpm-cook clean
	sudo rm -rf /opt/docker-registry
	sudo rm -rf /var/{run,log,lib}/docker-registry
	sudo rm -rf /etc/init.d/docker-registry
	sudo rm -rf /etc/default/docker-registry
	sudo rm -rf /etc/docker-registry/config.yml
