#!/bin/bash
set -e

case "$1" in
    rails|rake|passenger)
	# ensure the right database adapter is active in the Gemfile.lock
        if [ -z "$NO_BUNDLE" ]; then
            # bundle install  --without development test
            bundle install
            # all gems installed as root but in order to allow user to put
            # breakpoint into them they got chowned here.
            chown dev:dev $GEM_HOME -R
        fi

	if [ ! -s config/secrets.yml ]; then
	    if [ "$SYNLAB_SECRET_KEY_BASE" ]; then
		cat > 'config/secrets.yml' <<-YML
					$RAILS_ENV:
					  secret_key_base: "$SYNLAB_SECRET_KEY_BASE"
				YML
	    elif [ ! -f /usr/src/redmine/config/initializers/secret_token.rb ]; then
		rake generate_secret_token
	    fi
	fi
	if [ "$1" != 'rake' -a -z "$SYNLAB_NO_DB_MIGRATE" ]; then
	    gosu dev rake db:migrate
	fi

	# remove PID file to enable restarting the container
	rm -f /var/www/bpe/tmp/pids/server.pid

	if [ "$1" = 'passenger' ]; then
	    # Don't fear the reaper.
	    set -- tini -- "$@"
	fi

	set -- gosu dev "$@"
	;;
esac

exec "$@"

