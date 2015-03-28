# vim: set ts=2 sts=2 sw=2 et:

class Python < FPM::Cookery::Recipe

  description 'Python Programming Language'
  homepage 'http://www.python.org/'

  name 'python'
  version '2.7.9'
  revision 0

  source 'https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz'
  sha256 'c8bba33e66ac3201dabdc556f0ea7cfe6ac11946ec32d357c4c6f9b018c12c5b'

  maintainer '<zaa@ikato.com>'
  vendor     'fpm'
  license    'https://docs.python.org/2/license.html'

  section 'Interpreters'

  platforms [:fedora, :redhat, :centos] do
    build_depends 'bzip2-devel',
                  'gdbm-devel',
                  'sqlite-devel',
                  'libxml2-devel',
                  'ncurses-devel',
                  'readline-devel',
                  'openssl-devel'
                  
    depends       'zlib',
                  'bzip2',
                  'libxml2',
                  'gdbm',
                  'sqlite',
                  'ncurses',
                  'readline'
  end
  platforms [:fedora] do
    depends.push('openssl-libs')
  end
  platforms [:redhat, :centos] do
    depends.push('openssl')
  end

  def build
    configure :prefix => destdir
    make
  end

  def install
    # install Python
    make :install

    # install pip
    cleanenv_safesystem "#{destdir}/bin/python -m ensurepip"
  end
end
