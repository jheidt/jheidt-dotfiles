# -*- encoding: utf-8 -*-

#
# jheidt's kickass pry config
#

Pry.editor = proc { |file, line| "/usr/bin/subl #{file} +#{line}" }
Pry.config.theme = 'tomorrow'

Pry.config.ls.heading_color          = :white
Pry.config.ls.class_constant_color   = :bright_green
Pry.config.ls.instance_var_color     = :bright_blue
Pry.config.ls.protected_method_color = :bright_black
Pry.config.ls.private_method_color   = :yellow

def colour(name, text)
  if RUBY_PLATFORM =~ /java/
    Pry.color ? "#{Pry::Helpers::Text.send name, '{text}'}".sub('{text}', "#{text}") : text
  else
    Pry.color ? "\001#{Pry::Helpers::Text.send name, '{text}'}\002".sub('{text}', "\002#{text}\001") : text
  end
end

Pry.config.prompt = [
  proc do |object, nest_level, pry|
    prompt  = colour :bright_black, Pry.view_clip(object)
    prompt += ":" if nest_level > 0
    prompt += colour :bright_cyan, "#{nest_level}" if nest_level > 0
    prompt += colour :cyan, ' » '
  end, proc { |object, nest_level, pry| colour :cyan, '» ' }
]

begin
  require 'hirb'

  Hirb.enable

  old_print = Pry.config.print
  Pry.config.print = proc do |*args|
    Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
  end
rescue LoadError
  #...
end

# if defined? Hirb
#   # Dirty hack to support in-session Hirb.disable/enable
#   Hirb::View.instance_eval do
#     def enable_output_method
#       @output_method = true
#       Pry.config.print = proc do |output, value|
#         Hirb::View.view_or_page_output(value) || Pry::DEFAULT_PRINT.call(output, value)
#       end
#     end
#     def disable_output_method
#       Pry.config.print = proc { |output, value| Pry::DEFAULT_PRINT.call(output, value) }
#       @output_method = nil
#     end
#   end
#   Hirb.enable
# end

# # Log Rails stuff like SQL/Mongo queries to $stdout if in Rails console
# if defined?(Rails) && Rails.respond_to?(:logger)    # Rails 3 style
#   require 'logger'
#   Rails.logger = Logger.new($stdout)
#   def toggle_db_logging
#     if $db_logging_enabled
#       ActiveRecord::Base.logger = Logger.new(nil) if defined?(ActiveRecord)
#       Mongoid.logger = Logger.new(nil) if defined?(Mongoid)
#       Dalli.logger = Logger.new(nil) if defined?(Dalli)
#       Tire.configure { reset :logger } if defined?(Tire)
#       if defined?(MongoMapper)
#         MongoMapper.connection.instance_variable_set(:@logger, nil)
#       end
#       if $redis
#         $redis.client.logger = Logger.new(nil) # if !$redis.client.is_a?(MockRedis)
#       end
#       $db_logging_enabled = false
#     else
#       ActiveRecord::Base.logger = Rails.logger if defined?(ActiveRecord)
#       Mongoid.logger = Rails.logger if defined?(Mongoid)
#       Dalli.logger = Rails.logger if defined?(Dalli)
#       Tire.configure { logger $stdout } if defined?(Tire)
#       if defined?(MongoMapper)
#         MongoMapper.connection.instance_variable_set(:@logger, Logger.new(STDOUT))
#       end
#       if $redis
#         $redis.client.logger = Rails.logger # if !$redis.client.is_a?(MockRedis)
#       end
#       $db_logging_enabled = true
#     end
#   end
#   toggle_db_logging
# # Rails < 3.0.0
# elsif ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
#   require 'logger'
#   RAILS_DEFAULT_LOGGER = Logger.new($stdout)
# end