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
    ynh_add_config --template="url.properties" --destination="$install_dir/build/build/framework/webapp/config/url.properties"

    ynh_add_config --template="security.properties" --destination="$install_dir/build/framework/security/config/security.properties"

    ynh_replace_string --target_file="$install_dir/build/framework/catalina/ofbiz-component.xml" --match_string="8443" --replace_string="$port"

    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" --match_string="jdbc:postgresql://127.0.0.1/ofbiz" --replace_string="jdbc:postgresql://127.0.0.1:5432/${db_name}"
    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" --match_string="jdbc:postgresql://127.0.0.1/ofbizolap" --replace_string="jdbc:postgresql://127.0.0.1:5432/${db_name}olap"
    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" --match_string="jdbc:postgresql://127.0.0.1/ofbiztenant" --replace_string="jdbc:postgresql://127.0.0.1:5432/${db_name}tenant"
    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" --match_string="jdbc-username=\"ofbiz\"" --replace_string="jdbc-username=\"$db_user\""
    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" --match_string="jdbc-password=\"ofbiz\"" --replace_string="jdbc-password=\"$db_pwd\""
    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" \
        --match_string="group-map group-name=\"org.apache.ofbiz\" datasource-name=\"localderby\"" --replace_string="group-map group-name=\"org.apache.ofbiz\" datasource-name=\"localpostgres\""
    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" \
        --match_string="group-map group-name=\"org.apache.ofbiz.olap\" datasource-name=\"localderbyolap\"" --replace_string="group-map group-name=\"org.apache.ofbiz.olap\" datasource-name=\"localpostgresolap\""
    ynh_replace_string --target_file="$install_dir/build/framework/entity/config/entityengine.xml" \
        --match_string="group-map group-name=\"org.apache.ofbiz.tenant\" datasource-name=\"localderbytenant\"" --replace_string="group-map group-name=\"org.apache.ofbiz.tenant\" datasource-name=\"localpostgrestenant\""

    ynh_replace_string --target_file="$install_dir/build/framework/security/config/security.properties" --match_string="host-headers-allowed=.*" --replace_string="host-headers-allowed=$domain"
    ynh_replace_string --target_file="$install_dir/build/framework/security/config/security.properties" --match_string="security.ldap.enable=false" --replace_string="security.ldap.enable=true"
    ynh_replace_string --target_file="$install_dir/build/framework/security/config/jndiLdap.properties" --match_string="ldap.dn.template=cn=%u,ou=system" --replace_string="ldap.dn.template=uid=%u,ou=users,dc=yunohost,dc=org"
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
