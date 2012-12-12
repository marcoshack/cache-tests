import std;
include "/vagrant/etc/varnish/default.vcl";

sub vcl_fetch {
  if (beresp.http.Cache-Control ~ "(^|,) stale-if-error=") {
    set beresp.grace = std.duration(regsub(beresp.http.Cache-Control, "(^|.*,) stale-if-error=([0-9]*) *(,.*|$)", "\2s"), 0s);
    std.log("vcl_fetch: [rfc5861] stale-if-error detected, grace set to " + beresp.grace);
  }
}

sub vcl_recv {
  set req.grace = 24h;
}
