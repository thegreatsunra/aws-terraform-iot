resource "aws_dynamodb_table" "table_events" {
  name           = "${var.table_events}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"
  range_key      = "at"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "deviceId"
    type = "S"
  }

  attribute {
    name = "at"
    type = "S"
  }

  global_secondary_index {
    name               = "id-index"
    hash_key           = "id"
    range_key          = "at" # range key maps to sort key, i think
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "deviceId-index"
    hash_key           = "deviceId"
    range_key          = "at" # range key maps to sort key, i think
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "ALL"
  }

  tags {
    Name        = "table_tag_name"
    Environment = "table_tag_environment"
  }
}

resource "aws_dynamodb_table" "table_devices" {
  name           = "${var.table_devices}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  global_secondary_index {
    name               = "id-index"
    hash_key           = "id"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "ALL"
  }

  tags {
    Name        = "table_tag_name"
    Environment = "table_tag_environment"
  }
}
