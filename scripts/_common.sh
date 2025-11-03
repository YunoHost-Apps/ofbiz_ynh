#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

_ci_fix_nginx() {
    # Ofbiz returns a 404 on its root, so let's redirect to another path also served
    if ynh_in_ci_tests; then
        echo 'rewrite ^/$ /catalog/;' >> "../conf/nginx.conf"
    fi
}

_fixup_config() {
    ynh_config_add --template="url.properties" --destination="$install_dir/build/framework/webapp/config/url.properties"
    ynh_delete_file_checksum "$install_dir/build/framework/webapp/config/url.properties"

    ynh_config_add --template="security.properties" --destination="$install_dir/build/framework/security/config/security.properties"
    ynh_delete_file_checksum "$install_dir/build/framework/security/config/security.properties"

    ynh_config_add --template="catalina-component.xml" --destination="$install_dir/build/framework/catalina/ofbiz-component.xml"
    ynh_delete_file_checksum "$install_dir/build/framework/catalina/ofbiz-component.xml"

    ynh_config_add --template="entity-config.xml" --destination="$install_dir/build/framework/entity/config/entityengine.xml"
    ynh_delete_file_checksum "$install_dir/build/framework/entity/config/entityengine.xml"
}
