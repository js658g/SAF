# $Id: to_require.rb 95 2016-04-06 20:35:25Z e0c2506 $
# Using a global var as a dirty dirty hack. Don't do that.
$require_var ||= 0
$require_var += 1
