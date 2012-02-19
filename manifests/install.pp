# Basic Puppet Apache manifest
class install {
  
  exec { 'apt-get update': 
      command => '/usr/bin/apt-get update',
  }

  #
  # Aliases
  #
  exec { '/bin/cp /vagrant/resources/aliases.sh /etc/profile.d/': 
      command => '/bin/cp /vagrant/resources/aliases.sh /etc/profile.d/',
  }


  #
  # Java - jdk 6
  #
  exec { '/bin/chmod +x /vagrant/resources/oab-java6.sh': 
      command => '/bin/chmod +x /vagrant/resources/oab-java6.sh',
  }
  exec { '/vagrant/resources/oab-java6.sh': 
      command => '/vagrant/resources/oab-java6.sh',
  }  
  package { "sun-java6-jdk": ensure => present, }
  
  
  #
  # Tomcat
  #
  
  # install
  exec { '/bin/tar -zxvf /vagrant/resources/apache-tomcat-7.0.25.tar.gz -C /vagrant/data/': 
      command => '/bin/tar -zxvf /vagrant/resources/apache-tomcat-7.0.25.tar.gz -C /vagrant/data/',
  }
  # autostart  
  exec { '/bin/cp /vagrant/resources/tomcat /etc/init.d/': 
      command => '/bin/cp /vagrant/resources/tomcat /etc/init.d/',
  }
  exec { '/bin/chmod 755 /etc/init.d/tomcat': 
      command => '/bin/chmod 755 /etc/init.d/tomcat',
  }
  exec { '/bin/ln -s /etc/init.d/tomcat /etc/rc1.d/K99tomcat': 
      command => '/bin/ln -s /etc/init.d/tomcat /etc/rc1.d/K99tomcat',
  }
  exec { '/bin/ln -s /etc/init.d/tomcat /etc/rc2.d/S99tomcat': 
      command => '/bin/ln -s /etc/init.d/tomcat /etc/rc2.d/S99tomcat',
  }    


  #
  # NginX
  #
  package { "nginx": ensure => present, }

  service { "nginx":
    ensure => running,
    require => Package["nginx"],
  }
  
  
  
  #
  # CONFIGURING
  # 
  # NGINX: SANDBOX.LOCAL
  #
  exec { '/bin/ln -s /vagrant/resources/sandbox.local.conf /etc/nginx/sites-available/': 
      command => '/bin/ln -s /vagrant/resources/sandbox.local.conf /etc/nginx/sites-available/',
  }
  exec { '/bin/ln -s /vagrant/resources/sandbox.local.conf /etc/nginx/sites-enabled/': 
      command => '/bin/ln -s /vagrant/resources/sandbox.local.conf /etc/nginx/sites-enabled/',
  }  

  # 
  # TOMCAT: SANDBOX.LOCAL
  #
  exec { '/bin/cp /vagrant/resources/server.xml /vagrant/data/apache-tomcat-7.0.25/conf/': 
      command => '/bin/cp /vagrant/resources/server.xml /vagrant/data/apache-tomcat-7.0.25/conf/',
  }


  #
  # Small packages
  #
  package { "vim": ensure => present, }




  # Restart Tomcat and NginX
  exec { '/etc/init.d/tomcat start':  command => '/etc/init.d/tomcat start', }  
  exec { '/usr/sbin/nginx -s reload':  command => '/usr/sbin/nginx -s reload', }



}

include install


# TODO
#
# ok - vim
# ok - java + repo
# ok - aliases
# ok - tomcat
# ok - nginx
# ok - nginx - virtual hosts
# - mysql
# ok - acessar servidor web (nginx)
# -- - autostart tomcat quanto iniciar o servidor
# ok - acessar tomcat
# ok - tomcat virtualhost
# ok - nginx > tomcat (configurar)
#

