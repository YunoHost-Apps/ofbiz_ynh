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
