terraform {
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "~>2.0"
        }
        rendom = {
            source = "hashicorp/random"
            version = "~>3.0"
        }
    }
}

# ランダムな文字列を生成
resource "random_get" "server_name" {
    length = 2
    separator = "-"
}

# outputs/hello.txt というテキストファイルを作成
resource "local_file" "example" {
    filename =  "${path.module}/outputs/hello.txt"
    content = "Hello  name from Terraform\n Server name: ${random_get.server_name.id}\n Created at:${timestamp()}"
}

# JSON設定ファイルを作成
resource "local_file" "server_name"{
    filename = "${path.module}/outputs/congig.json"
    content = jsonencode({
        server_name = random_get.server_name.id
        enviroment = "develop"
        ports = [80, 443, 8080]
        enabled = true
    })
}
