#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

#=================================================
# PERSONAL HELPERS
#=================================================

_ci_fix_nginx() {
    # Ofbiz returns a 404 on its root, so let's redirect to another path also served
    if [ "${PACKAGE_CHECK_EXEC:-0}" -eq 1 ]; then
        echo 'rewrite ^/$ /catalog/;' >> "../conf/nginx.conf"
    fi
}

_fixup_config() {
    ynh_add_config --template="url.properties" --destination="$install_dir/build/framework/webapp/config/url.properties"
    ynh_delete_file_checksum --file="$install_dir/build/framework/webapp/config/url.properties"

    ynh_add_config --template="security.properties" --destination="$install_dir/build/framework/security/config/security.properties"
    ynh_delete_file_checksum --file="$install_dir/build/framework/security/config/security.properties"

    ynh_add_config --template="catalina-component.xml" --destination="$install_dir/build/framework/catalina/ofbiz-component.xml"
    ynh_delete_file_checksum --file="$install_dir/build/framework/catalina/ofbiz-component.xml"

    ynh_add_config --template="entity-config.xml" --destination="$install_dir/build/framework/entity/config/entityengine.xml"
    ynh_delete_file_checksum --file="$install_dir/build/framework/entity/config/entityengine.xml"
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
