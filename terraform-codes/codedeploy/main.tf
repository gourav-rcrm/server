provider "aws" {
  region = "us-east-2"
}

resource "aws_codedeploy_app" "web_2build" {
  name             = "web-2build"
  compute_platform = "Server"
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRoleForLambda"
  role       = "arn:aws:iam::713136486137:role/Codedeploy-IAM"
}

resource "aws_codedeploy_deployment_group" "ohio_dg" {
  app_name               = aws_codedeploy_app.web_2build.name
  deployment_group_name  = "ohio-dg"
  service_role_arn       = aws_iam_role_policy_attachment.codedeploy.role
  deployment_config_name = "CodeDeployDefault.EC2AllAtOnce"
  
  ec2_tag_set {
    key   = "Name"
    value = "ohio_1"
  }

  trigger_configuration {
    trigger_events = ["DeploymentStart"]
  }

  deployment_style {
    deployment_type = "IN_PLACE"
  }

  ec2_tag_filter {}
}
