output "target_group_arns" {
  value = [for tg in aws_lb_target_group.static_web_target_group : tg.arn]
}
