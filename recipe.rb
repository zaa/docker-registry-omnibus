# vim: set ts=2 sts=2 sw=2 et:

class DockerRegistry < FPM::Cookery::Recipe

  description 'Docker Registry Omnibus Package'
  homepage 'https://github.com/docker/docker-registry'

  name     'docker-registry-omnibus'
  version  '0.9.1'
  revision  0

  source '', :with => :noop

  maintainer '<zaa@ikato.com>'
  license    'Apache License Version 2.0'

  section 'Services'

  omnibus_package true
  omnibus_dir     "/opt/#{name}"
  omnibus_recipes 'python27'

  platforms [:fedora, :redhat, :centos] do
    pre_install    'files/pre-install'
    post_install   'files/post-install'

    pre_uninstall  'files/pre-uninstall'
    post_uninstall 'files/post-uninstall'
  end

  platforms [:fedora, :redhat, :centos] do
    config_files '/etc/docker-registry/config.yml',
                 '/etc/default/docker-registry',
                 '/etc/init.d/docker-registry'
  end
  omnibus_additional_paths config_files

  platforms [:fedora, :redhat, :centos] do
    build_depends 'rpmdevtools',
                  'swig',
                  'xz-devel',
                  'libevent-devel',
                  'libyaml-devel'

    depends       'libevent',
                  'libyaml'
  end

  def build
    # prepare /etc/init.d/docker-registry candidate
    safesystem "curl -L -o docker-registry.initd https://raw.githubusercontent.com/docker/docker-registry/master/contrib/docker-registry_RHEL.sh"
    safesystem "sed -i'.bak' -e 's|/usr/bin/gunicorn|#{destdir}/embedded/bin/gunicorn|' docker-registry.initd"
  end

  def install
    # install docker-registry from pip
    cleanenv_safesystem "#{destdir}/embedded/bin/pip install docker-registry==#{version}"

    # /etc/docker-registry/config.yml
    safesystem "mkdir -p /etc/docker-registry"
    safesystem "install -m 0644 #{destdir}/embedded/lib/python2.7/site-packages/config/config_sample.yml /etc/docker-registry/config.yml"

    # /etc/init.d/docker-registry
    safesystem "install -m 0755 #{builddir}/docker-registry.initd /etc/init.d/docker-registry"

    # /etc/default/docker-registry
    safesystem "install -m 0644 #{workdir}/files/docker-registry.default /etc/default/docker-registry"
  end

end
