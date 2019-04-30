# Sending keypair to aws in order to use it with our instances
resource "aws_key_pair" "chainkey"{
  key_name = "chainkey"
  public_key = "${file("${var.public_key}")}"
}
