output "id" {
  description = "The ID of the created launch template."
  value       = aws_launch_template.alt.id
}

output "latest_version" {
  description = "The latest version number of the launch template."
  value       = aws_launch_template.alt.latest_version
}
