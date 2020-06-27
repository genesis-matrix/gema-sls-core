##
##
##



##_META:
##



## <JINJA>
{# #+TODO: identify/cultivate a convention for tidy jinja-imports #}
## </JINJA>



# (jinja-import) install openscap for oscap binary
{% include 'state/machine/software/openscap/init.sls' with context %}



# (jinja-import) install osquery
{% include 'state/machine/software/osquery/init.sls' with context %}



## EOF
