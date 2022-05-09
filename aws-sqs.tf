resource "aws_sqs_queue" "cv-content-queue" {
  name                        = "cv-content-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  tags = {
    environment = "production"
    project = "cloud-challenge"
    generated_by = "terraform-cloud"
  }
}