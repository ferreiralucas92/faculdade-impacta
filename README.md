# Project IAC Faculdade Impacta

Antes de iniciar deve conter na maquina onde o codigo será executado, a ACCESS KEY e a SECRET KEY pertencentes a AWS. Caso não tenha execute:
aws configure
Passe suas credenciais de acesso.

# Para executar a construção da EC2 expondo o serviço, execute:

terraform init > o mesmo dará inicio a comunicação com o Provider, no nosso caso é a AWS, mas serve para qualquer provedor que o terraform tenha suporte.
terraform validate > irá validar se o codigo está correto
terraform plan > trará uma estimativa do que irá ser criado.
terraform apply --auto-approve > começa a construção ja validada

 # No nosso exemplo, somente estamos passando os parametros de criação da instancia, então será criado de maneira automatica a VPC, Subnet, PublicIP, Volume Size (será utilizado o padrão do instance type). Caso seja necessario passar parametros existe, podem ser adicionados em variable, conforme exemplo abaixo:

variable "aws" {
    type = "string"
    default = {
    region = "PASSAR A REGIÃO DESEJADA"
    vpc = "PASSAR A VPC ID"
    subnet = "NOME DA SUBNET"
    secgroupname = "NOME DO SG"
  }
}
# Passar as variaveis dentro do campo resources para que ela seja adicionado no momento correto, exemplo:
resource "aws_instance" "project-iac" {
  subnet_id = var.subnet
  vpc_id = vpc

