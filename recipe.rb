class DockerRegistry < FPM::Cookery::Recipe

  description 'Docker Registry'
  homepage 'https://github.com/docker/docker-registry'

  name     'docker-registry'
  version  '0.9.1'
  revision  0

  source '', :with => :noop

  maintainer '<zaa@ikato.com>'
  vendor     'fpm'
  license    'MIT'

  section 'Services'

  omnibus_package true
  omnibus_dir     "/opt/#{name}"
  omnibus_recipes 'python'

# TODO: Set up paths to initscript and config files per platform
#  platforms [:fedora, :redhat, :centos] do
#    config_files '/etc/docker-registry/docker-registry.conf',
#                 '/etc/init.d/docker-registry',
#                 '/etc/sysconfig/docker-registry'
#  end
#  omnibus_additional_paths config_files

  platforms [:fedora, :redhat, :centos] do
    build_depends 'rpmdevtools',
                  'swig',
                  'xz-devel',
                  'libevent-devel',
                  'libyaml-devel'

    depends 'swig',
            'xz',
            'libevent',
            'libyaml'
  end

  def build
  end

  def install
    cleanenv_safesystem "#{destdir}/embedded/bin/pip install docker-registry==#{version}"
  end

end
