# ActsAsFlyingSaucer
#
module ActsAsFlyingSaucer
  
  # Config
  #
  class Config
    # default options
    @@options = {
      :java_bin => "java",
      :classpath_separator => ':',
      :tmp_path => "/tmp",
      :run_mode => :once,
      :nailgun=> false
    }
    
    cattr_accessor :options
  end
  
end
