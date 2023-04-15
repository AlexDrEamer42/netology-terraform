    variable "valid_ip" {
            type = string
            description = "IP address"
            default = "1.1.1.1"
            validation {
              condition = length(regexall("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$",var.valid_ip)) > 0
              error_message = "IP address is invalid"
      }
    }

    variable "valid_ips" {
            type = list(string)
            description = "IP address"
            default = ["1.1.1.222","2.2.2.2","3.3.3.255"]
            validation {
              condition = alltrue( [ for ip in var.valid_ips: length(regexall("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$",ip)) > 0 ] )
              error_message = "One or more IP addresses are invalid"
      }
    }

    variable "any_string" {
            type = string
            description = "Any string"
            default = "drfgtht"
            validation {
              condition = lower(var.any_string) == var.any_string
              error_message = "One or more uppercase symbols detected"
      }
    }

    variable "in_the_end_there_can_be_only_one" {
       description="Who is better Connor or Duncan?"
       type = object({
          Dunkan = optional(bool)
          Connor = optional(bool)
       })

       default = {
          Dunkan = false
          Connor = true
       }

       validation {
          error_message = "There can be only one MacLeod"
          condition = anytrue(values(tomap(var.in_the_end_there_can_be_only_one))) && !(alltrue(values(tomap(var.in_the_end_there_can_be_only_one))))
       }
}