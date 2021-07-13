# Task Definition
# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "main" {
  family = "handson"

  # データプレーンの選択
  requires_compatibilities = ["FARGATE"]

  # ECSタスクが使用可能なリソースの上限
  # タスク内のコンテナはこの上限内に使用するリソースを収める必要があり、メモリが上限に達した場合OOM Killer にタスクがキルされる
  cpu    = "256"
  memory = "512"

  # ECSタスクのネットワークドライバ
  # Fargateを使用する場合は"awsvpc"決め打ち
  network_mode = "awsvpc"

  # 起動するコンテナの定義
  # 「nginxを起動し、80ポートを開放する」設定を記述。
  container_definitions = <<EOL
[
  {
    "name": "nginx",
    "image": "nginx:1.14",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOL
}



# ECS Cluster
# https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html
resource "aws_ecs_cluster" "main" {
  name = "handson"
}



# ELB Target Group
# https://www.terraform.io/docs/providers/aws/r/lb_target_group.html
resource "aws_lb_target_group" "main" {
  name = "handson"

  # ターゲットグループを作成するVPC
  vpc_id = "${aws_vpc.main.id}"

  # ALBからECSタスクのコンテナへトラフィックを振り分ける設定
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  # コンテナへの死活監視設定
  health_check = {
    port = 80
    path = "/"
  }
}

# ALB Listener Rule
# https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html
resource "aws_lb_listener_rule" "main" {
  # ルールを追加するリスナー
  listener_arn = "${aws_lb_listener.main.arn}"

  # 受け取ったトラフィックをターゲットグループへ受け渡す
  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.main.id}"
  }

  # ターゲットグループへ受け渡すトラフィックの条件
  condition {
    field  = "path-pattern"
    values = ["*"]
  }
}