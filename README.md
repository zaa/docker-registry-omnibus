# Introduction

This is an Omnibus project that will build a "monolithic" OS package for
Docker Registry.  It installs an embedded version of python along with
all python packages required by the docker-registry project. This makes
is possible to run the Docker Registry without taking into account what
version of the Python Language or of the required packages is installed
on the host system.

# How to build the omnibus package

1. Checkout the repository
2. Run `vagrant up`
3. SSH into the box: `vagrant ssh`
4. Change working directory to `/vagrant`
5. Run `make`

# How to install the omnibus package

The steps above would produce an RPM in the `/vagrant/pkg/` directory
which you can copy to a RHEL/CentOS box and install using `rpm`.  The
package will include Python 2.7.x along with dockery-registry `pip`
package and all the related packages and files.

# How to start Docker Registry

1. Install the project as mentioned above
2. Run `/etc/init.d/docker-registry start` (the service would start
   automatically during the OS startup since the RPM installation step
   adds it to the list of automatically started projects via
   `chkconfig`).
