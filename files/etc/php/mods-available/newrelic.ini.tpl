;
; Copyright 2020 New Relic Corporation. All rights reserved.
; SPDX-License-Identifier: Apache-2.0
;

; This file contains the various settings for the New Relic PHP agent. There
; are many options, all of which are described in detail at the following URL:
; https://docs.newrelic.com/docs/agents/php-agent/configuration/php-agent-configuration
;

; If you use a full path to the extension you insulate yourself from the
; extension directory changing if you change PHP installations or versions.
; If you do not use an absolute path then the file must be installed in the
; active configuration's extension directory.
extension = "newrelic.so"

[newrelic]
; Setting: newrelic.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enable or disable the agent. Please note that you cannot globally
;          disable the agent and then selectively enable it on a per-directory
;          basis. If you disable the agent in the global INI file then the
;          agent will not initialize at all. However, you can selectively
;          disable the agent on a per-directory basis.
;
;newrelic.enabled = true
newrelic.enabled = $NEWRELIC_ENABLED ; override

; Setting: newrelic.license
; Type   : string
; Scope  : per-directory
; Default: none
; Info   : Sets the New Relic license key to use. This can vary from directory
;          to directory if you are running a multi-tenant system. By special
;          dispensation if you upgraded from a previous version of the agent
;          where the license key was set in the daemon, the installation and
;          upgrade script will have preserved your license key from the file
;          /etc/newrelic/newrelic.cfg, but ONLY if you installed via rpm/yum
;          or dpkg. The key is saved in /etc/newrelic/upgrade_please.key
;          and the agent will look for that file if you do not specify a valid
;          license here.
;          It is *STRONGLY* recommended that you set the license key in your
;          INI file(s) and do not rely on the key file being present. Also
;          please note that even if you are not letting the agent start the
;          daemon and are still using newrelic.cfg (see below) the license
;          keyword in that file is no longer obeyed. Instead the agent will
;          use the preserved value of that license from the key file.
;          Once you have updated your INI files to contain the license we
;          urge you to remove /etc/newrelic/upgrade_please.key in order to
;          eliminate the potential for confusion about exactly where the key
;          is coming from.
;
;newrelic.license = ""
newrelic.license = "$NEWRELIC_LICENSE" ; override

; Setting: newrelic.logfile
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets the name of the file to send log messages to.
;
;newrelic.logfile = "/var/log/newrelic/php_agent.log"
newrelic.logfile = "$NEWRELIC_LOGFILE" ; override

; Setting: newrelic.loglevel
; Type   : string
; Scope  : system
; Default: "info"
; Info   : Sets the level of detail to include in the log file. You should
;          rarely need to change this from the default, and usually only under
;          the guidance of technical support.
;          Must be one of the following values:
;            always, error, warning, info, verbose, debug, verbosedebug
;
;newrelic.loglevel = "info"
newrelic.loglevel = "$NEWRELIC_LOGLEVEL" ; override

; Setting: newrelic.high_security
; Type   : boolean
; Scope  : system
; Default: false
; Info   : Enables high security for all applications. When high security is
;          enabled, the following behavior will take effect:
;          * Raw SQL strings will never be gathered, regardless of the value of
;            newrelic.transaction_tracer.record_sql.
;          * Request parameters will never be captured, regardless of the
;            newrelic.attributes configuration settings.
;          * The following API functions will have no effect, and will return
;            false:
;            newrelic_add_custom_parameter
;            newrelic_set_user_attributes
;            newrelic_record_custom_event
;
;          IMPORTANT:  If you change this setting, you must also change the RPM
;          UI security setting. If the two settings do not match, then no data
;          will be collected.
;
;          IMPORTANT: This setting is not compatible with
;          newrelic.security_policies_token. Only one may be set. If both are
;          set an error will be thrown and the agent will not connect.
;
;newrelic.high_security = false
newrelic.high_security = $NEWRELIC_HIGH_SECURITY ; override

; Setting: newrelic.appname
; Type   : string
; Scope  : per-directory
; Default: "PHP Application"
; Info   : Sets the name of the application that metrics will be reported into.
;          This can in fact be a list of up to 3 application names, each of
;          which must be separated by a semi-colon. The first name in any such
;          list is considered the 'primary' application name and must be unique
;          for each account / license key.
;
;newrelic.appname = "PHP Application"
newrelic.appname = "$NEWRELIC_APPNAME" ; override

; Setting: newrelic.process_host.display_name
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets a custom display name for your application server in the New
;          Relic UI. Servers are normally identified by host and port number.
;          This setting allows you to give your hosts more recognizable names.
;
;newrelic.process_host.display_name = ""
newrelic.process_host.display_name = "$NEWRELIC_PROCESS_HOST_DISPLAY_NAME" ; override

;
; Beginning with version 3.0 of the agent, the daemon can be automatically
; started by the agent. There is no need to start the daemon before starting
; Apache or PHP-FPM. All of the newrelic.daemon.* settings are options that
; control the behavior of the daemon. These settings are converted into the
; appropriate command line options when the agent starts the daemon. This is
; now the preferred method of starting the daemon. There are still usage cases
; (such as using a single daemon for serving multiple Apache instances) where
; you may want to start the daemon via it's init script, but for most users,
; this is the best place to configure and start the daemon.
;
; The agent will only launch the daemon if one isn't already running. Also
; note that the agent will NOT stop the daemon once it has started. If you
; want control over exactly when the daemon starts and stops you can still
; achieve that by creating a daemon configuration file (located by default at
; /etc/newrelic/newrelic.cfg) and running the chkconfig or equivalent command.
; Please see the newrelic.cfg template file for details. That template file
; is located at /usr/lib/newrelic-php5/scripts/newrelic.cfg.template.
;
; Also please note that the options here and in newrelic.cfg are identical,
; except that in this file they are preceded with "newrelic.daemon.".
;

; Setting: newrelic.daemon.logfile
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets the name of the file to send daemon log messages to.
;
;newrelic.daemon.logfile = "/var/log/newrelic/newrelic-daemon.log"
newrelic.daemon.logfile = "$NEWRELIC_DAEMON_LOGFILE" ; override

; Setting: newrelic.daemon.loglevel
; Type   : string
; Scope  : system
; Default: "info"
; Info   : Sets the level of detail to include in the daemon log. You should
;          rarely need to change this from the default, and usually only under
;          the guidance of technical support.
;          Must be one of the following values:
;            always, error, warning, info, healthcheck, debug
;
;          The values verbose and verbosedebug are deprecated aliases for debug.
;
;newrelic.daemon.loglevel = "info"
newrelic.daemon.loglevel = "$NEWRELIC_DAEMON_LOGLEVEL" ; override

; Setting: newrelic.daemon.address (alias: newrelic.daemon.port)
; Type   : string or integer
; Scope  : system
; Default: "@newrelic" on Linux, "/tmp/.newrelic.sock" otherwise
; Info   : Sets how the agent and daemon communicate. How this is set can impact
;          performance.
;
;          On Linux, the default is to use the abstract socket "@newrelic". An
;          abstract socket can be created by prefixing the socket name with '@'.
;
;          On MacOS and FreeBSD, the default is to use a UNIX-domain socket
;          located at "/tmp/.newrelic.sock". If you want to use UNIX domain
;          sockets then this value must begin with a '/'. 
;
;          If you set this to an integer value in the range 1-65535, then this
;          will instruct the agent to use a normal TCP socket on the port 
;          specified. This may be easier to use if you are using a chroot 
;          environment.
;
;          To connect to a daemon that is running on a different host, set this
;          value to '<host>:<port>', where '<host>' denotes either a host name
;          or an IP address and '<port>' denotes a valid port number. IPv6 is
;          supported.
;
;          In order to use a TCP socket with a port in the range 1-1023,
;          the daemon must be started by the super-user. This is a fundamental
;          OS limitation and not one imposed by the daemon itself.
;
;newrelic.daemon.address = "/tmp/.newrelic.sock"
newrelic.daemon.address = "$NEWRELIC_DAEMON_ADDRESS" ; override

; Setting: newrelic.daemon.ssl_ca_bundle
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets the location of a file containing CA certificates in PEM
;          format. When set, the certificates in this file will be used to
;          authenticate the New Relic collector servers. If
;          newrelic.daemon.ssl_ca_path is also set (see below), the
;          certificates in this file will be searched first, followed by the
;          certificates contained in the newrelic.daemon.ssl_ca_path
;          directory.
;
;newrelic.daemon.ssl_ca_bundle = ""
newrelic.daemon.ssl_ca_bundle = "$NEWRELIC_DAEMON_SSL_CA_BUNDLE" ; override

; Setting: newrelic.daemon.ssl_ca_path
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets the location of a directory containing trusted CA certificates
;          in PEM format. When set, the certificates in this directory will be
;          used to authenticate the New Relic collector servers. If
;          newrelic.daemon.ssl_ca_bundle is also set (see above), it will be
;          searched first followed by the certificates contained in
;          newrelic.daemon.ssl_ca_path.
;
;newrelic.daemon.ssl_ca_path = ""
newrelic.daemon.ssl_ca_path = "$NEWRELIC_DAEMON_SSL_CA_PATH" ; override

; Setting: newrelic.daemon.proxy
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets the host and user credentials to use as an egress proxy. This
;          is only used if your site requires a proxy in order to access
;          external servers on the internet, in this case the New Relic data
;          collection servers. This is expressed in one of the following forms:
;             hostname
;             hostname:port
;             user@hostname
;             user@hostname:port
;             user:password@hostname
;             user:password@hostname:port
;
;newrelic.daemon.proxy = ""
newrelic.daemon.proxy = "$NEWRELIC_DAEMON_PROXY" ; override

; Setting: newrelic.daemon.pidfile
; Type   : string
; Scope  : system
; Default: OS dependent
; Info   : Sets the name of the file to store the running daemon's process ID
;          (PID) in. This file is used by the daemon startup and shutdown
;          script to determine whether or not the daemon is already running.
;
;newrelic.daemon.pidfile = ""
newrelic.daemon.pidfile = "$NEWRELIC_DAEMON_PIDFILE" ; override

; Setting: newrelic.daemon.location
; Type   : string
; Scope  : system
; Default: /usr/bin/newrelic-daemon
; Info   : Sets the name of the daemon executable to launch.
;          Please note that on OpenSolaris where /usr is frequently a read-only
;          file system, the default daemon location is
;          /opt/newrelic/bin/newrelic-daemon.
;
;newrelic.daemon.location = "/usr/bin/newrelic-daemon"
newrelic.daemon.location = "$NEWRELIC_DAEMON_LOCATION" ; override

; Setting: newrelic.daemon.collector_host
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets the host name of the New Relic data collector host to use.
;          Please note that this is NOT any form of local host. It refers to
;          the New Relic provided host. There is very little reason to ever
;          change this from the default except in certain very special
;          circumstances, and then only on instruction from a New Relic sales
;          person or support staff member.
;
;newrelic.daemon.collector_host = ""
newrelic.daemon.collector_host = "$NEWRELIC_DAEMON_COLLECTOR_HOST" ; override

; Setting: newrelic.daemon.dont_launch
; Type   : integer (0, 1, 2 or 3)
; Scope  : system
; Default: 0
; Info   : If you prefer to have the daemon launched externally before the
;          agent starts up, set this variable to non-zero. The value you
;          choose determines exactly when the agent is allowed to start the
;          daemon:
;          0 - agent can start the daemon any time it needs to
;          1 - non-CLI (i.e Apache / php-fpm) agents can start the daemon
;          2 - only CLI agents can start the daemon
;          3 - the agent will never start the daemon
;
;newrelic.daemon.dont_launch = 0
newrelic.daemon.dont_launch = $NEWRELIC_DAEMON_DONT_LAUNCH ; override

; Setting: newrelic.daemon.utilization.detect_aws
; Type   : boolean
; Scope  : system
; Default: true
; Info   : Enable detection of whether the system is running on AWS. This will
;          create a small amount of network traffic on daemon startup.
;
;newrelic.daemon.utilization.detect_aws = true
newrelic.daemon.utilization.detect_aws = $NEWRELIC_DAEMON_UTILIZATION_DETECT_AWS ; override

; Setting: newrelic.daemon.utilization.detect_azure
; Type   : boolean
; Scope  : system
; Default: true
; Info   : Enable detection of whether the system is running on Azure. This will
;          create a small amount of network traffic on daemon startup.
;
;newrelic.daemon.utilization.detect_azure = true
newrelic.daemon.utilization.detect_azure = $NEWRELIC_DAEMON_UTILIZATION_DETECT_AZURE ; override

; Setting: newrelic.daemon.utilization.detect_gcp
; Type   : boolean
; Scope  : system
; Default: true
; Info   : Enable detection of whether the system is running on Google Cloud
;          Platform. This will create a small amount of network traffic on
;          daemon startup.
;
;newrelic.daemon.utilization.detect_gcp = true
newrelic.daemon.utilization.detect_gcp = $NEWRELIC_DAEMON_UTILIZATION_DETECT_GCP ; override

; Setting: newrelic.daemon.utilization.detect_pcf
; Type   : boolean
; Scope  : system
; Default: true
; Info   : Enable detection of whether the system is running on Pivotal Cloud
;          Foundry.
;
;newrelic.daemon.utilization.detect_pcf = true
newrelic.daemon.utilization.detect_pcf = $NEWRELIC_DAEMON_UTILIZATION_DETECT_PCF ; override

; Setting: newrelic.daemon.utilization.detect_docker
; Type   : boolean
; Scope  : system
; Default: true
; Info   : Enable detection of a system running on Docker. This will be used
;          to support future features.
;
;newrelic.daemon.utilization.detect_docker = true
newrelic.daemon.utilization.detect_docker = $NEWRELIC_DAEMON_UTILIZATION_DETECT_DOCKER ; override

; Setting: newrelic.daemon.utilization.detect_kubernetes
; Type   : boolean
; Scope  : system
; Default: true
; Info   : Enable detection of whether the system is running in a Kubernetes 
;          cluster.
;
;newrelic.daemon.utilization.detect_kubernetes = true
newrelic.daemon.utilization.detect_kubernetes = $NEWRELIC_DAEMON_UTILIZATION_DETECT_KUBERNETES ; override


; Setting: newrelic.daemon.app_timeout
; Type   : time specification string ("5m", "1h20m", etc)
; Scope  : system
; Default: 10m
; Info   : Sets the elapsed time after which an application will be considered
;          inactive. Inactive applications do not count against the maximum
;          limit of 250 applications. Allowed units are "ns", "us", "ms", "s",
;          "m", and "h".
;
;          A value of 0 is interpreted as "no timeout". New applications with
;          this setting count toward the 250 application limit. In addition, with
;          a 0-value setting, the agent's daemon process cannot release a small
;          amount of memory per application back to the operating system.
;
;          We do not recommend using a 0-value setting except under the guidance
;          of technical support; instead, for occasional background transactions,
;          we suggest using a value of twice the interval (so, for an hourly
;          background job, set the timeout to 2 hours).
;newrelic.daemon.app_timeout = 10m
newrelic.daemon.app_timeout = $NEWRELIC_DAEMON_APP_TIMEOUT ; override

; Setting: newrelic.daemon.app_connect_timeout
; Type   : time specification string ("1s", "5m", etc)
; Scope  : system
; Default: 0
; Info   : Sets the maximum time the agent should wait for the daemon 
;          connecting an application.  A value of 0 causes the agent to only
;          make one attempt at connecting to the daemon.  Allowed units are 
;          "ns", "us", "ms", "s", "m", and "h".
;
;          With this timeout set, the agent will not immediately drop a
;          transaction when the daemon hasn't connected to the backend yet, but
;          rather grant the daemon time to establish the connection.
;
;          If setting a timeout, the recommended value is 10s.  It is
;          recommended to only set this timeout when instrumenting long-lived
;          background tasks, as in case of connection problems the agent will
;          block for the given timeout at every transaction start.
;
;newrelic.daemon.app_connect_timeout = 0
newrelic.daemon.app_connect_timeout = $NEWRELIC_DAEMON_APP_CONNECT_TIMEOUT ; override

; Setting: newrelic.daemon.start_timeout
; Type   : time specification string ("1s", "5m", etc)
; Scope  : system
; Default: 0
; Info   : Sets the maximum time the agent should wait for the daemon 
;          to start after a daemon launch was triggered.  A value of 0 causes
;          the agent to not wait.  Allowed units are "ns", "us", "ms", "s", "m"
;          and "h".
;
;          The specified timeout value will be passed to the daemon via the
;          --wait-for-port flag.  This causes daemon startup to block until a
;          socket is acquired or until the timeout has elapsed.
;
;          If setting a timeout, the recommended value is 2s to 5s.  It is
;          recommended to only set this timeout when instrumenting long-lived
;          background tasks, as in case of daemon start problems the agent will
;          block for the given timeout at every transaction start.
;
;newrelic.daemon.start_timeout = 0
newrelic.daemon.start_timeout = $NEWRELIC_DAEMON_START_TIMEOUT ; override

; Setting: newrelic.error_collector.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enable the New Relic error collector. This will record the 20 most
;          severe errors per harvest cycle. It is rare to want to disable this.
;          Please also note that your New Relic subscription level may force
;          this to be disabled regardless of any value you set for it.
;
;newrelic.error_collector.enabled = true
newrelic.error_collector.enabled = $NEWRELIC_ERROR_COLLECTOR_ENABLED ; override

; Setting: newrelic.error_collector.ignore_user_exception_handler
; Type   : boolean
; Scope  : per-directory
; Default: false
; Info   : If enabled, the New Relic error collector will ignore any exceptions
;          that are handled by an exception handler installed with
;          set_exception_handler().
;
;          If an exception handler has not been installed, this setting will
;          have no effect, as PHP will turn the uncaught exception into a fatal
;          error and it will be handled accordingly by the New Relic error
;          collector.
;
;newrelic.error_collector.ignore_user_exception_handler = false
newrelic.error_collector.ignore_user_exception_handler = $NEWRELIC_ERROR_COLLECTOR_IGNORE_USER_EXCEPTION_HANDLER ; override

; Setting: newrelic.error_collector.ignore_exceptions
; Type:    string
; Scope:   per-directory
; Default: none
; Info:    A comma separated list of exception classes that the agent should
;          ignore. When an unhandled exception occurs, the agent will perform
;          the equivalent of `$exception instanceof Class` for each of the
;          classes listed. If any of those checks returns true, the agent
;          will not record an error.
;
;          Please note that this setting only applies to uncaught exceptions.
;          Exceptions recorded using the newrelic_notice_error API are not
;          subject to filtering.
;
;newrelic.error_collector.ignore_exceptions = ""
newrelic.error_collector.ignore_exceptions = "$NEWRELIC_ERROR_COLLECTOR_IGNORE_EXCEPTIONS" ; override

; Setting: newrelic.error_collector.ignore_errors
; Type:    int or a bitwise expression of PHP-defined error constants
; Scope:   per-directory
; Default: none
; Info:    Sets the error levels that the agent should ignore.
;
;          The value for this setting uses similar syntax to the error syntax
;          for the PHP error reporting.  For example, to configure the PHP Agent
;          to ignore E_WARNING and E_ERROR level errors, use:
;
;          newrelic.error_collector.ignore_errors = E_WARNING | E_ERROR
;
;          or
;
;          newrelic.error_collector.ignore_errors = 3
;
;          The list of constants are available at:
;          http://php.net/manual/en/errorfunc.constants.php
;
;          Please note that this setting does not apply to errors recorded
;          using the newrelic_notice_error API.
;
;newrelic.error_collector.ignore_errors = 0
newrelic.error_collector.ignore_errors = $NEWRELIC_ERROR_COLLECTOR_IGNORE_ERRORS ; override

; Setting: newrelic.error_collector.record_database_errors
; Type   : boolean
; Scope  : per-directory
; Default: false
; Info   : Currently only supported for MySQL database functions. If enabled,
;          this will cause errors returned by various MySQL functions to be
;          treated as if they were PHP errors, and thus subject to error
;          collection. This is only obeyed if the error collector is enabled
;          above and the account subscription level permits error trapping.
;
;newrelic.error_collector.record_database_errors = false
newrelic.error_collector.record_database_errors = $NEWRELIC_ERROR_COLLECTOR_RECORD_DATABASE_ERRORS ; override

; Setting: newrelic.error_collector.prioritize_api_errors
; Type   : boolean
; Scope  : per-directory
; Default: false
; Info   : If the error collector is enabled and you use the New Relic API to
;          notice an error, if this is set to true then assign the highest
;          priority to such errors.
;
;newrelic.error_collector.prioritize_api_errors = false
newrelic.error_collector.prioritize_api_errors = $NEWRELIC_ERROR_COLLECTOR_PRIORITIZE_API_ERRORS ; override

; Setting: newrelic.browser_monitoring.auto_instrument
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables automatic real user monitoring ("auto-RUM").
;          When enabled will cause the agent to insert a header and a footer
;          in HTML output that will time the actual end-user experience.
;
;newrelic.browser_monitoring.auto_instrument = true
newrelic.browser_monitoring.auto_instrument = $NEWRELIC_BROWSER_MONITORING_AUTO_INSTRUMENT ; override

; Setting: newrelic.transaction_tracer.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables the transaction tracer. When enabled this will
;          produce a detailed call graph for any transaction that exceeds a
;          certain threshold (see next entry). Only one transaction trace per
;          application per harvest cycle is stored and it is always the slowest
;          transaction during that cycle. Transaction traces are extremely
;          useful when diagnosing problem spots in your application. Please
;          note that TT's may be disabled by your account subscription level
;          regardless of what you set here.
;
;newrelic.transaction_tracer.enabled = true
newrelic.transaction_tracer.enabled = $NEWRELIC_TRANSACTION_TRACER_ENABLED ; override

; Setting: newrelic.transaction_tracer.threshold
; Type   : string with a time specification or the word "apdex_f"
; Scope  : per-directory
; Default: "apdex_f"
; Info   : Specifies the threshold above which a transaction becomes a
;          candidate for the transaction tracer. This can either be an absolute
;          time value like "200ms" or "1s250ms" or "1h30m" or "750us" or the
;          word "apdex_f". This last value, "apdex_f", means "4 times apdex_t".
;          Thus the threshold changes according to your apdex_t setting. This
;          is the default.
;
;newrelic.transaction_tracer.threshold = "apdex_f"
newrelic.transaction_tracer.threshold = "$NEWRELIC_TRANSACTION_TRACER_THRESHOLD" ; override

; Setting: newrelic.transaction_tracer.detail
; Type   : integer in the range 0-1
; Scope  : per-directory
; Default: 1
; Info   : Sets the level of detail in a transaction trace. Setting this to 0
;          will only show the relatively few PHP functions that New Relic has
;          deemed to be "interesting", as well as any custom functions you set
;          (see below). A setting of 1 will trace and time all user functions.
;
;          In earlier releases of the agent this was known as "top100".
;
;newrelic.transaction_tracer.detail = 1
newrelic.transaction_tracer.detail = $NEWRELIC_TRANSACTION_TRACER_DETAIL ; override

; Setting: newrelic.transaction_tracer.slow_sql
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables the "slow SQL" tracer. When enabled, this will
;          record the top 10 slowest SQL calls along with a stack trace of
;          where the call occurred in your code.
;
;newrelic.transaction_tracer.slow_sql = true
newrelic.transaction_tracer.slow_sql = $NEWRELIC_TRANSACTION_TRACER_SLOW_SQL ; override

; Setting: newrelic.transaction_tracer.stack_trace_threshold
; Type   : time specification string ("500ms", "1s750ms" etc)
; Scope  : per-directory
; Default: 500ms
; Info   : Sets the threshold above which the New Relic agent will record a
;          stack trace for a transaction trace.
;
;newrelic.transaction_tracer.stack_trace_threshold = 500
newrelic.transaction_tracer.stack_trace_threshold = $NEWRELIC_TRANSACTION_TRACER_STACK_TRACE_THRESHOLD ; override

; Setting: newrelic.transaction_tracer.explain_enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables requesting "explain plans" from MySQL databases
;          accessed via MySQLi or PDO_MySQL for slow SQL calls. The threshold
;          for requesting explain plans is defined below.
;
;newrelic.transaction_tracer.explain_enabled = true
newrelic.transaction_tracer.explain_enabled = $NEWRELIC_TRANSACTION_TRACER_EXPLAIN_ENABLED ; override

; Setting: newrelic.transaction_tracer.explain_threshold
; Type   : time specification string ("750ms", "1s 500ms" etc)
; Scope  : per-directory
; Default: 500ms
; Info   : Used by the slow SQL tracer to set the threshold above which an SQL
;          statement is considered "slow", and to set the threshold above which
;          the transaction tracer will request an "explain plan" from the data-
;          base for slow SQL. This latter feature may not be active yet, please
;          refer to the agent release notes to see when it becomes available.
;          Only relevant if explain_enabled above is set to true.
;
;newrelic.transaction_tracer.explain_threshold = 500
newrelic.transaction_tracer.explain_threshold = $NEWRELIC_TRANSACTION_TRACER_EXPLAIN_THRESHOLD ; override

; Setting: newrelic.transaction_tracer.record_sql
; Type   : "off", "raw" or "obfuscated"
; Scope  : per-directory
; Default: "obfuscated"
; Info   : Sets how SQL statements are recorded (if at all). If this is set to
;          "raw" then no attempt is made at obfuscating SQL statements.
;          USING "raw" IS HIGHLY DISCOURAGED IN PRODUCTION ENVIRONMENTS!
;          Setting this to "raw" has considerable security implications as it
;          can expose sensitive and private customer data.
;
;newrelic.transaction_tracer.record_sql = "obfuscated"
newrelic.transaction_tracer.record_sql = "$NEWRELIC_TRANSACTION_TRACER_RECORD_SQL" ; override

; Setting: newrelic.transaction_tracer.custom
; Type   : string
; Scope  : per-directory
; Default: none
; Info   : Sets the name(s) of additional functions you want to instrument and
;          appear in transaction traces. This is only meaningful if you have
;          set newrelic.transaction_tracer.detail to 0. This can be a comma-
;          separated list of function or class method names.
;
;newrelic.transaction_tracer.custom = ""
newrelic.transaction_tracer.custom = "$NEWRELIC_TRANSACTION_TRACER_CUSTOM" ; override

; Setting: newrelic.transaction_tracer.internal_functions_enabled
; Type   : boolean
; Scope  : system
; Default: false
; Info   : Enables or disables support for tracing internal functions (that is,
;          functions written in C and provided either via the PHP standard
;          library or PECL extensions). When enabled, internal functions will
;          appear in transaction traces like functions written in PHP.
;
;          Note that enabling this option may result in transactions being up to
;          5% slower. Enabling this option is only recommended when specifically
;          debugging performance issues where an internal function is suspected
;          to be slow.
;
;newrelic.transaction_tracer.internal_functions_enabled = false
newrelic.transaction_tracer.internal_functions_enabled = $NEWRELIC_TRANSACTION_TRACER_INTERNAL_FUNCTIONS_ENABLED ; override

; Setting: newrelic.framework
; Type   : string
; Scope  : per-directory
; Default: empty (auto-detect framework)
; Info   : Disables automatic framework detection, telling the agent to
;          attempt to name transactions according to the specified framework.
;          Specifying "no_framework" will disable framework-related transaction
;          naming entirely. Please let us know at support.newrelic.com if you
;          encounter a failure with framework autodetection.
;
;          Must be one of the following values:
;          cakephp, codeigniter, drupal, drupal8, joomla, kohana, laravel,
;          magento, magento2, mediawiki, slim, symfony2, symfony4,
;          wordpress, yii, zend, zend2, no_framework
;
;          Note that "drupal" covers only Drupal 6 and 7 and "symfony2"
;          now only supports Symfony 3.x.
;
;newrelic.framework = ""
newrelic.framework = "$NEWRELIC_FRAMEWORK" ; override

; Setting: newrelic.webtransaction.name.remove_trailing_path
; Type   : boolean
; Scope  : per-directory
; Default: false
; Info   : Used to aid naming transactions correctly when an unsupported
;          framework is being used. This option will cause anything after the
;          script name to be stripped from a URL. For example, setting this
;          would cause the "/xyz/zy" to be stripped from a URL such as
;          "/path/to/foo.php/xyz/zy".
;
;newrelic.webtransaction.name.remove_trailing_path = false
newrelic.webtransaction.name.remove_trailing_path = $NEWRELIC_WEBTRANSACTION_NAME_REMOVE_TRAILING_PATH ; override

; Setting: newrelic.webtransaction.name.functions
; Type   : string
; Scope  : per-directory
; Default: none
; Info   : Unless a specific framework such as Drupal or Wordpress has been
;          detected, transactions are named according to the first script
;          encountered, such as login.php. However, if you use a dispatcher
;          file such as index.php this produces less useful data. If you use
;          a dispatcher to redirect to actions such as "login", "show", "edit"
;          etc, you can set this to the top level functions for those actions,
;          and the function names specified here will be used to name the
;          transaction.
;
;newrelic.webtransaction.name.functions = ""
newrelic.webtransaction.name.functions = "$NEWRELIC_WEBTRANSACTION_NAME_FUNCTIONS" ; override

; Setting: newrelic.webtransaction.name.files
; Type   : string
; Scope  : per-directory
; Default: none
; Info   : Same as newrelic.webtransaction.name.functions above but using file
;          names instead of function names. Accepts standard POSIX regular
;          expressions.
;
;newrelic.webtransaction.name.files = ""
newrelic.webtransaction.name.files = "$NEWRELIC_WEBTRANSACTION_NAME_FILES" ; override

; Setting: newrelic.daemon.auditlog
; Type   : string
; Scope  : system
; Default: none
; Info   : Sets the name of a file to record all uncompressed, un-encoded
;          content that is sent from your machine to the New Relic servers.
;          This includes the full URL for each command along with the payload
;          delivered with the command. This allows you to satisfy yourself
;          that the agent is not sending any sensitive data to our servers.
;          This file must be a different file the the newrelic.daemon.logfile
;          setting above. If you set it to the same name,
;          then audit logging will be silently ignored.
;
;newrelic.daemon.auditlog = "/var/log/newrelic/audit.log"
newrelic.daemon.auditlog = "$NEWRELIC_DAEMON_AUDITLOG" ; override

; Setting: newrelic.transaction_events.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Collect and report transaction analytics event data. Event data
;          allows the New Relic UI to show additional information such as
;          histograms. This setting was formerly called
;          newrelic.analytics_events.enabled.
;
;newrelic.transaction_events.enabled = true
newrelic.transaction_events.enabled = $NEWRELIC_TRANSACTION_EVENTS_ENABLED ; override

; Setting: newrelic.attributes.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enable or disable the collection of attributes generated by the
;          agent or generated by the user though newrelic_add_custom_parameter.
;          This setting will take precedence over all other attribute
;          configuration settings. For more information, please refer to:
;          https://docs.newrelic.com/docs/agents/manage-apm-agents/agent-metrics/agent-attributes
;
;newrelic.attributes.enabled = true
newrelic.attributes.enabled = $NEWRELIC_ATTRIBUTES_ENABLED ; override

; Setting: newrelic.transaction_events.attributes.enabled
;          newrelic.transaction_tracer.attributes.enabled
;          newrelic.error_collector.attributes.enabled
;          newrelic.browser_monitoring.attributes.enabled
;          newrelic.span_events.attributes.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true, except for browser_monitoring.attributes.enabled
; Info   : Control which destinations receive attributes.
;          These configuration settings will override the .include and .exclude
;          settings below. For more information, please refer to:
;          https://docs.newrelic.com/docs/agents/manage-apm-agents/agent-metrics/agent-attributes
;
;          These settings were formerly called:
;          newrelic.transaction_tracer.capture_attributes
;          newrelic.error_collector.capture_attributes
;          newrelic.analytics_events.capture_attributes
;          newrelic.browser_monitoring.capture_attributes
;
;newrelic.transaction_events.attributes.enabled = true
newrelic.transaction_events.attributes.enabled = $NEWRELIC_TRANSACTION_EVENTS_ATTRIBUTES_ENABLED ; override
;newrelic.transaction_tracer.attributes.enabled = true
newrelic.transaction_tracer.attributes.enabled = $NEWRELIC_TRANSACTION_TRACER_ATTRIBUTES_ENABLED ; override
;newrelic.error_collector.attributes.enabled = true
newrelic.error_collector.attributes.enabled = $NEWRELIC_ERROR_COLLECTOR_ATTRIBUTES_ENABLED ; override
;newrelic.browser_monitoring.attributes.enabled = false
newrelic.browser_monitoring.attributes.enabled = $NEWRELIC_BROWSER_MONITORING_ATTRIBUTES_ENABLED ; override
;newrelic.span_events.attributes.enabled = true
newrelic.span_events.attributes.enabled = $NEWRELIC_SPAN_EVENTS_ATTRIBUTES_ENABLED ; override

; Setting: newrelic.attributes.include
;          newrelic.attributes.exclude
;
;          newrelic.transaction_events.attributes.include
;          newrelic.transaction_events.attributes.exclude
;
;          newrelic.transaction_tracer.attributes.include
;          newrelic.transaction_tracer.attributes.exclude
;
;          newrelic.error_collector.attributes.include
;          newrelic.error_collector.attributes.exclude
;
;          newrelic.browser_monitoring.attributes.include
;          newrelic.browser_monitoring.attributes.exclude
;
;          newrelic.span_events.attributes.include
;          newrelic.span_events.attributes.exclude
;
; Type   : string
; Scope  : per-directory
; Default: none
; Info   : Each attribute has a default set of destinations. For example, the
;          'request_uri' attribute's default destinations are errors and
;          transaction traces. The 'httpResponseCode' attribute's default
;          destinations are errors, transaction traces, and transaction events.
;
;          These configuration options allow complete control over the
;          destinations of attributes.
;
;          To include the attribute whose key is 'alpha' in errors, the
;          configuration is:
;          newrelic.error_collector.include = alpha
;
;          To exclude the attribute whose key is 'alpha' from errors, the
;          configuration is:
;          newrelic.error_collector.exclude = alpha
;
;          The newrelic.attributes.exclude and newrelic.attributes.include
;          settings affect all destinations.
;
;          To exclude the attributes 'beta' and 'gamma' from all destinations,
;          the configuration is:
;          newrelic.attributes.exclude = beta,gamma
;
;          If one of the values in the comma separated list ends in a '*',
;          it will match any suffix. For example, to exclude any attributes
;          which begin with 'psi', the configuration is:
;          newrelic.attributes.exclude = psi*
;
;          For more information, please refer to:
;          https://docs.newrelic.com/docs/agents/manage-apm-agents/agent-metrics/agent-attributes
;
;newrelic.attributes.include = ""
newrelic.attributes.include = "$NEWRELIC_ATTRIBUTES_INCLUDE" ; override
;newrelic.attributes.exclude = ""
newrelic.attributes.exclude = "$NEWRELIC_ATTRIBUTES_EXCLUDE" ; override
;
;newrelic.transaction_events.attributes.include = ""
newrelic.transaction_events.attributes.include = "$NEWRELIC_TRANSACTION_EVENTS_ATTRIBUTES_INCLUDE" ; override
;newrelic.transaction_events.attributes.exclude = ""
newrelic.transaction_events.attributes.exclude = "$NEWRELIC_TRANSACTION_EVENTS_ATTRIBUTES_EXCLUDE" ; override
;
;newrelic.transaction_tracer.attributes.include = ""
newrelic.transaction_tracer.attributes.include = "$NEWRELIC_TRANSACTION_TRACER_ATTRIBUTES_INCLUDE" ; override
;newrelic.transaction_tracer.attributes.exclude = ""
newrelic.transaction_tracer.attributes.exclude = "$NEWRELIC_TRANSACTION_TRACER_ATTRIBUTES_EXCLUDE" ; override
;
;newrelic.error_collector.attributes.include = ""
newrelic.error_collector.attributes.include = "$NEWRELIC_ERROR_COLLECTOR_ATTRIBUTES_INCLUDE" ; override
;newrelic.error_collector.attributes.exclude = ""
newrelic.error_collector.attributes.exclude = "$NEWRELIC_ERROR_COLLECTOR_ATTRIBUTES_EXCLUDE" ; override
;
;newrelic.browser_monitoring.attributes.include = ""
newrelic.browser_monitoring.attributes.include = "$NEWRELIC_BROWSER_MONITORING_ATTRIBUTES_INCLUDE" ; override
;newrelic.browser_monitoring.attributes.exclude = ""
newrelic.browser_monitoring.attributes.exclude = "$NEWRELIC_BROWSER_MONITORING_ATTRIBUTES_EXCLUDE" ; override
;
;newrelic.span_events.attributes.include = ""
newrelic.span_events.attributes.include = "$NEWRELIC_SPAN_EVENTS_ATTRIBUTES_INCLUDE" ; override
;newrelic.span_events.attributes.exclude = ""
newrelic.span_events.attributes.exclude = "$NEWRELIC_SPAN_EVENTS_ATTRIBUTES_EXCLUDE" ; override

; Setting: newrelic.feature_flag
; Type   : string
; Scope  : system
; Default: none
; Info   : Enables new and experimental features within the PHP agent. These
;          flags are used to selectively enable features that are intended to be
;          enabled by default in later versions of the PHP agent.
;
;newrelic.feature_flag = ""
newrelic.feature_flag = "$NEWRELIC_FEATURE_FLAG" ; override

; Setting: newrelic.custom_insights_events.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables the API function newrelic_record_custom_event.
;
;newrelic.custom_insights_events.enabled = true
newrelic.custom_insights_events.enabled = $NEWRELIC_CUSTOM_INSIGHTS_EVENTS_ENABLED ; override

; Setting: newrelic.custom_events.max_samples_stored
; Type   : integer
; Scope  : per-directory
; Default: 30000
; Info   : The default Custom Events reservoir limit in the agent is 
;          30000 events per minute and the maximum allowed value
;          is 100000 events per minute.
;
;newrelic.custom_events.max_samples_stored = 30000
newrelic.custom_events.max_samples_stored = $NEWRELIC_CUSTOM_EVENTS_MAX_SAMPLES_STORED ; override

; Setting: newrelic.labels
; Type   : string (Use quotes)
; Scope  : per-directory
; Default: none
; Info   : Sets the label names and values to associate with the application.
;          The list is a semi-colon delimited list of colon-separated name and
;          value pairs.
;
;          There are a maximum of 64 label name/value pairs allowed.
;
;          The maximum length of the name and value is 255 characters each.
;
;          Leading or trailing whitespace in the name or value will be trimmed.
;
;          UTF-8 characters are allowed.
;
;          E.g., "Server:One;Data Center:Primary"
;
;newrelic.labels = ""
newrelic.labels = "$NEWRELIC_LABELS" ; override

; Setting: newrelic.synthetics.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables support for Synthetics transactions.
;          For more information, please see:
;          https://docs.newrelic.com/docs/synthetics/new-relic-synthetics/getting-started/new-relic-synthetics
;
;newrelic.synthetics.enabled = true
newrelic.synthetics.enabled = $NEWRELIC_SYNTHETICS_ENABLED ; override

; Setting: newrelic.cross_application_tracer.enabled
; Type   : boolean
; Scope  : per-directory
; Default: false
; Info   : Enables or disables support for Cross Application Tracing, aka "CAT".
;          NOTE: As of April 2022 CAT has been deprecated and will be removed at a future date.
;
;newrelic.cross_application_tracer.enabled = false
newrelic.cross_application_tracer.enabled = $NEWRELIC_CROSS_APPLICATION_TRACER_ENABLED ; override

; Setting: newrelic.distributed_tracing_enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Distributed tracing lets you see the path that a request takes
;          through your distributed system. See this guide for more information:
;          https://docs.newrelic.com/docs/distributed-tracing/concepts/introduction-distributed-tracing
;          When distributed tracing is enabled it changes the behavior of some
;          New Relic features. See this guide for details:
;          https://docs.newrelic.com/docs/transition-guide-distributed-tracing
;
;newrelic.distributed_tracing_enabled = true
newrelic.distributed_tracing_enabled = $NEWRELIC_DISTRIBUTED_TRACING_ENABLED ; override

; Setting: newrelic.distributed_tracing_exclude_newrelic_header
; Type   : boolean
; Scope  : per-directory
; Default: false
; Info   : Set this to true to exclude the New Relic distributed tracing header
;          that is attached to outbound requests, and to instead only rely on
;          W3C Trace Context Headers for distributed tracing. If this is false
;          then both types of headers are attached to outbound requests.
;
;          The New Relic distributed tracing header allows interoperability
;          with older agents that do not support W3C Trace Context headers.
;          Agent versions that support W3C Trace Context headers will
;          prioritize them over New Relic headers for distributed tracing.    
;
;newrelic.distributed_tracing_exclude_newrelic_header = false
newrelic.distributed_tracing_exclude_newrelic_header = $NEWRELIC_DISTRIBUTED_TRACING_EXCLUDE_NEWRELIC_HEADER ; override

; Setting: newrelic.span_events_enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables the creation of span events. This requires
;          Distributed Tracing to be enabled.
;
;newrelic.span_events_enabled = true
newrelic.span_events_enabled = $NEWRELIC_SPAN_EVENTS_ENABLED ; override

; Setting: newrelic.span_events.max_samples_stored
; Type   : unsigned integer
; Scope  : per-directory
; Default: 2000
; Info   : The maximum number of span events added to the span event reservoir
;          per transaction. A value of 0 will use the agent default.  The max
;          setting is 10000.
;
;          !IMPORTANT: If you have Code Level Metrics enabled & long absolute
;          pathnames to your PHP files/functions, you may exceed the max message
;          size limit set by the Daemon if your max_samples_stored setting is
;          too high. To fix this, you can either:
;           a) enable infinite tracing (newrelic.infinite_tracing.trace_observer.host)
;           b) set newrelic.code_level_metrics.enabled=false, disabling it
;              entirely
;           c) lower the value for newrelic.span_events.max_samples_stored
;
;newrelic.span_events.max_samples_stored = 0
newrelic.span_events.max_samples_stored = $NEWRELIC_SPAN_EVENTS_MAX_SAMPLES_STORED ; override


; Setting: newrelic.infinite_tracing.trace_observer.host
; Type   : string
; Scope  : per-directory
; Default:
; Info   : Configures the Trace Observer used for Infinite Tracing. If empty,
;          Infinite Tracing support will be disabled. This requires Distributed
;          Tracing and span events to be enabled.
;
;newrelic.infinite_tracing.trace_observer.host=

; Setting: newrelic.infinite_tracing.trace_observer.port
; Type   : integer
; Scope  : per-directory
; Default: 443
; Info   : Configures the port used to communicate with the Infinite Tracing
;          Trace Observer. This setting is ignored if
;          newrelic.infinite_tracing.trace_observer.host is empty. This setting
;          will not usually need to be changed.
;
;newrelic.infinite_tracing.trace_observer.port=443

; Setting: newrelic.infinite_tracing.span_events.queue_size
; Type   : integer (1000 or higher)
; Scope  : per-directory
; Default: 100000
; Info   : Sets the number of span events that can be queued for transmission
;          to the Infinite Tracing Trace Observer.
;
;          The agent internally manages span events for Infinite Tracing in
;          span batches. Those span batches can hold a maximum of 1000 spans.
;          Therefore, the span events queue size cannot be lower than 1000, as
;          otherwise not even a single span batch can be queued. If a queue
;          size lower than 1000 is specified, the mininum size of 1000 is used.
;
;newrelic.infinite_tracing.span_events.queue_size=100000

; Setting: newrelic.transaction_tracer.gather_input_queries
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables support for tracing Doctrine DQL with Slow SQL queries.
;          This requires Slow SQLs to be enabled.
;
;newrelic.transaction_tracer.gather_input_queries = true
newrelic.transaction_tracer.gather_input_queries = $NEWRELIC_TRANSACTION_TRACER_GATHER_INPUT_QUERIES ; override

; Setting: newrelic.error_collector.capture_events
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables capturing error events, which are displayed as
;          Error Analytics in the UI.
;
;newrelic.error_collector.capture_events = true
newrelic.error_collector.capture_events = $NEWRELIC_ERROR_COLLECTOR_CAPTURE_EVENTS ; override

; Setting: newrelic.guzzle.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables support for the Guzzle library.
;
;newrelic.guzzle.enabled = true
newrelic.guzzle.enabled = $NEWRELIC_GUZZLE_ENABLED ; override

; Setting: newrelic.phpunit_events.enabled
; Type   : boolean
; Scope  : per-directory
; Default: false
; Info   : Collect and report PHPUnit (https://phpunit.de/) data as custom
;          Insights events. Test suite summary data are sent as "TestSuite"
;          events, while individual test cases are sent as "Test" events.
;          Depending on your events retention policy, enabling this setting may
;          impact your billing statement.
;
;          Please note that exception messages are collected and sent with
;          events. Additionally, if you use PHPUnit's --disallow-test-output
;          flag, any offending output from a risky test will also be included.
;
;newrelic.phpunit_events.enabled = false
newrelic.phpunit_events.enabled = $NEWRELIC_PHPUNIT_EVENTS_ENABLED ; override

; Setting: newrelic.datastore_tracer.instance_reporting.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables capturing datastore instance information,
;          specifically host and port_path_or_id. This information is sent as a
;          metric and as attributes on transaction traces and slow SQL traces.
;
;newrelic.datastore_tracer.instance_reporting.enabled = true
newrelic.datastore_tracer.instance_reporting.enabled = $NEWRELIC_DATASTORE_TRACER_INSTANCE_REPORTING_ENABLED ; override

; Setting: newrelic.datastore_tracer.database_name_reporting.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Enables or disables capturing information about database names. This
;          information is sent as an attribute on transaction traces and slow
;          SQL traces.
;
;newrelic.datastore_tracer.database_name_reporting.enabled = true
newrelic.datastore_tracer.database_name_reporting.enabled = $NEWRELIC_DATASTORE_TRACER_DATABASE_NAME_REPORTING_ENABLED ; override

; Setting: newrelic.security_policies_token
; Type   : string
; Scope  : per-directory
; Default: none
; Info   : Enables or disables security policies. If security policies are
;          enabled on your account, you should paste the security policies token
;          from the New Relic APM UI here.
;
;          IMPORTANT: This setting is not compatible with newrelic.high_security.
;          Only one may be set. If both are set an error will be thrown and the
;          agent will not connect.
;
;newrelic.security_policies_token = ""
newrelic.security_policies_token = "$NEWRELIC_SECURITY_POLICIES_TOKEN" ; override

; Setting: newrelic.preload_framework_library_detection
; Type   : boolean
; Scope  : system
; Default: true
; Info   : Enables detection of frameworks and libraries from opcache.
;
;          This only happens when preloading is enabled (when `opcache.preload`
;          is set).
;
;newrelic.preload_framework_library_detection = true
newrelic.preload_framework_library_detection = $NEWRELIC_PRELOAD_FRAMEWORK_LIBRARY_DETECTION ; override

; setting: newrelic.transaction_tracer.max_segments_web
; type   : integer in the range 0 - 2^31-1
; scope  : per-directory
; default: 0
; info   : Specifies the maximum number of segments the PHP agent shall
;          record, once that maximum is reached sampling will occur.
;
;          The PHP agent reports transaction traces and distributed traces as a
;          collection of segments.
;          Each segment represents a method or a function call in a transaction
;          trace. The default value for this configuration is 0, indicating that
;          the PHP agent shall capture all segments during a transaction. At the
;          end of a transaction, it assembles the highest priority segments to
;          report in a transaction trace.
;
;          For long-running PHP processes with hundreds of thousands or millions
;          of function calls, setting this to a value greater than 1 prevents the
;          PHP agent from exhausting system memory when recording segments.
;
;          Segment size can vary based upon the length of the corresponding
;          method's name, the length of its class name, and the number of
;          subsequent calls made by the method. That said, a conservative estimate
;          is 400 bytes per segment. To limit the PHP agent to 40 mb for segment
;          capture, set this value to 100000.  If this value is set lower than
;          2000, it further limits the total number of segments reported for
;          transaction traces.
;
;          This configuration setting is only for PHP web processes; it will not
;          effect PHP CLI processes. To set a limit for CLI processes use
;          newrelic.transaction_tracer.max_segments_cli.
;newrelic.transaction_tracer.max_segments_web = 0
newrelic.transaction_tracer.max_segments_web = $NEWRELIC_TRANSACTION_TRACER_MAX_SEGMENTS_WEB ; override

; setting: newrelic.transaction_tracer.max_segments_cli
; type   : integer in the range 0 - 2^31-1
; scope  : per-directory
; default: 100000
; info   : Specifies the maximum number of segments the PHP agent shall
;          record, once that maximum is reached sampling will occur.
;
;          The PHP agent reports a transaction trace as a collection of segments.
;          each segment represents a method or a function call in a transaction
;          trace. The default value for this configuration is 100000. When a value
;          of less than 1 is set, it will indicate that the PHP agent shall capture
;          all segments during a transaction. At the end of a transaction, the agent
;          assembles the highest priority segments to report in a transaction trace.
;
;          For long-running PHP processes with hundreds of thousands or millions
;          of function calls, setting this to a value greater than 1 prevents the
;          PHP agent from exhausting system memory when recording segments.
;
;          Segment size can vary based upon the length of the corresponding
;          method's name, the length of its class name, and the number of
;          subsequent calls made by the method. That said, a conservative estimate
;          is 400 bytes per segment. To limit the PHP agent to 40 mb for segment
;          capture, set this value to 100000. If this value is set lower than 2000,
;          it further limits the total number of segments reported for transaction
;          traces.
;
;          This configuration setting is only for PHP CLI processes; it will not
;          effect PHP web processes. To set a limit for web processes use
;          newrelic.transaction_tracer.max_segments_web.
;newrelic.transaction_tracer.max_segments_cli = 100000
newrelic.transaction_tracer.max_segments_cli = $NEWRELIC_TRANSACTION_TRACER_MAX_SEGMENTS_CLI ; override

; Setting: newrelic.capture_params
; Info   : This setting has been deprecated.
;          It was formerly used to capture request parameters.
;          It has been replaced by the attribute configuration settings.
;          To replicate this setting with the new settings, one would use:
;
;          newrelic.transaction_tracer.attributes.include = request.parameters.*
;          newrelic.error_collector.attributes.include = request.parameters.*
;
;          Please refer to the attribute configuration options for more
;          information.

; Setting: newrelic.ignored_params
; Info   : This setting has been deprecated.
;          It was formerly used to filter request parameters.
;          It has been replaced by the attribute configuration settings.
;          If you would like to exclude the request parameter 'alpha', use:
;
;          newrelic.attributes.exclude = request.parameters.alpha
;
;          Please refer to the attribute configuration options for more
;          information.

; Setting: newrelic.framework.drupal.modules
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Indicates if Drupal modules, hooks and views are to be instrumented.
;
;newrelic.framework.drupal.modules = true
newrelic.framework.drupal.modules = $NEWRELIC_FRAMEWORK_DRUPAL_MODULES ; override

; Setting: newrelic.framework.wordpress.hooks
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Indicates if WordPress hooks are to be instrumented.
;
;newrelic.framework.wordpress.hooks = true
newrelic.framework.wordpress.hooks = $NEWRELIC_FRAMEWORK_WORDPRESS_HOOKS ; override

; Setting: newrelic.application_logging.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : An overall configuration for enabling/disabling all application
;          logging features. If this is disabled, all sub-features are disabled;
;          if it is enabled, the individual sub-feature configurations
;          take effect.
;
;newrelic.application_logging.enabled = true
newrelic.application_logging.enabled = $NEWRELIC_APPLICATION_LOGGING_ENABLED ; override

; Setting: newrelic.application_logging.forwarding.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Toggles whether the agent gathers log records for sending to New Relic.
;
;newrelic.application_logging.forwarding.enabled = true
newrelic.application_logging.forwarding.enabled = $NEWRELIC_APPLICATION_LOGGING_FORWARDING_ENABLED ; override

; Setting: newrelic.application_logging.forwarding.max_samples_stored
; Type   : integer
; Scope  : per-directory
; Default: 10000
; Info   : Number of log records to send per minute to New Relic. Controls the 
;          overall memory consumption when using log forwarding.
;
;newrelic.application_logging.forwarding.max_samples_stored = 10000
newrelic.application_logging.forwarding.max_samples_stored = $NEWRELIC_APPLICATION_LOGGING_FORWARDING_MAX_SAMPLES_STORED ; override

; Setting: newrelic.application_logging.forwarding.log_level
; Type   : string
; Scope  : per-directory
; Default: "WARNING"
; Info   : Sets the minimum log level to be collected when log forwarding
;          is enabled. 
;
;          Based on
;           https://www.php-fig.org/psr/psr-3/#5-psrlogloglevel
;           https://datatracker.ietf.org/doc/html/rfc5424
;
;          Valid settings (ordered highest to lowest):
;           "EMERGENCY"
;           "ALERT"
;           "CRITICAL"
;           "ERROR"
;           "WARNING"
;           "NOTICE"
;           "INFO"
;           "DEBUG"
;          
;newrelic.application_logging.forwarding.log_level = "WARNING"
newrelic.application_logging.forwarding.log_level = "$NEWRELIC_APPLICATION_LOGGING_FORWARDING_LOG_LEVEL" ; override

; Setting: newrelic.application_logging.metrics.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Toggles whether the agent gathers the Logging/lines and
;          Logging/lines/{SEVERITY} Logging Metrics used in the Logs chart
;          on the APM Summary page.
;
;newrelic.application_logging.metrics.enabled = true
newrelic.application_logging.metrics.enabled = $NEWRELIC_APPLICATION_LOGGING_METRICS_ENABLED ; override

; Setting: newrelic.code_level_metrics.enabled
; Type   : boolean
; Scope  : per-directory
; Default: true
; Info   : Toggles whether the agent provides function name, function
;          filepath, function namespace, and function lineno as
;          attributes on reported spans
;
;          !IMPORTANT: If you have Code Level Metrics enabled & long absolute
;          pathnames to your PHP files/functions, you may exceed the max message
;          size limit set by the Daemon if your max_samples_stored setting is
;          too high. To fix this, you can either:
;           a) enable infinite tracing (newrelic.infinite_tracing.trace_observer.host)
;           b) set newrelic.code_level_metrics.enabled=false, disabling it
;              entirely
;           c) lower the value for newrelic.span_events.max_samples_stored
;
;newrelic.code_level_metrics.enabled = true
newrelic.code_level_metrics.enabled = $NEWRELIC_CODE_LEVEL_METRICS_ENABLED ; override
