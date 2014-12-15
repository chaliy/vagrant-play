node 'default' {
  package { "git" :
        ensure => "latest",
        provider => 'chocolatey'
  }
  # package { "SublimeText3" :
  #       ensure => "latest",
  #       provider => 'chocolatey'
  # }
}
