resource "datadog_monitor" "HTTP_Check_Devops3" {
  no_data_timeframe = 10
  notify_no_data    = true
  name              = "HTTP Check Devops3"
  type              = "service check"
  query             = <<EOT
"http.can_connect".over("*").by("host").last(2).count_by_status()
EOT
  message           = <<EOT
HTTP Check failed
{{#is_alert}}
HTTP service check failed for host: {{host.name}}
{{/is_alert}}

{{#is_recovery}}
HTTP service check recovered for host: {{host.name}}
{{/is_recovery}}
EOT

  tags = ["service:http", "environment:production"]
}
