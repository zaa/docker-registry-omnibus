set -ex

sudo yum -y --exclude='kernel*' update
sudo yum -y install ruby ruby-devel rubygems gcc git
sudo gem install bundler --no-rdoc --no-ri

cd /vagrant
bundler install
