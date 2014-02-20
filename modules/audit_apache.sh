# audit_apache
#
# The action in this section describes disabling the Apache 1.x and 2.x web
# servers provided with Solaris 10. Both services are disabled by default.
# Run control scripts for Apache 1 and the NCA web servers still exist,
# but the services will only be started if the respective configuration
# files have been set up appropriately, and these configuration files do not
# exist by default.
# Even if the system is a Web server, the local site may choose not to use
# the Web server provided with Solaris in favor of a locally developed and
# supported Web environment. If the machine is a Web server, the administrator
# is encouraged to search the Web for additional documentation on Web server
# security.
#.

audit_apache () {
  if [ "$os_name" = "SunOS" ]; then
    if [ "$os_version" = "10" ] || [ "$os_version" = "11" ]; then
      funct_verbose_message "Apache"
    fi
    if [ "$os_version" = "10" ]; then
      service_name="svc:/network/http:apache2"
      funct_service $service_name disabled
    fi
    if [ "$os_version" = "11" ]; then
      service_name="svc:/network/http:apache22"
      funct_service $service_name disabled
    fi
    if [ "$os_version" = "10" ]; then
      service_name="apache"
      funct_service $service_name disabled
    fi
  fi
  if [ "$os_name" = "Linux" ]; then
    funct_verbose_message "Apache and web based services"
    for service_name in httpd apache tomcat5 squid prixovy; do
      funct_chkconfig_service $service_name 3 off
      funct_chkconfig_service $service_name 5 off
    done
  fi
}