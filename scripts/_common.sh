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

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
