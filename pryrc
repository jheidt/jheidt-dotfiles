# -*- encoding: utf-8 -*-
require 'rubygems'


# == Pry-Nav - Using pry as a debugger ==
Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil
Pry.commands.alias_command 'r!', 'reload!' rescue nil

Pry.config.color = true
Pry.editor = proc { |file, line| "/usr/bin/subl #{file} +#{line}" }
Pry.config.theme = 'tomorrow'


# === CUSTOM PROMPT ===
# This prompt shows the ruby version (useful for RVM)
#
# Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]
#
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


# === Listing config ===
# Better colors - by default the headings for methods are too
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme
# for your terminal
# Pry.config.ls.separator = "\n" # new lines between methods
# Pry.config.ls.heading_color = :magenta
# Pry.config.ls.public_method_color = :green
# Pry.config.ls.protected_method_color = :yellow
# Pry.config.ls.private_method_color = :bright_black

# == PLUGINS ===
# awesome_print gem: great syntax colorized printing
# look at ~/.aprc for more settings for awesome_print
begin
  begin
    require 'pry-clipboard'
    Pry.config.commands.alias_command 'ch', 'copy-history'
    Pry.config.commands.alias_command 'cr', 'copy-result'
  rescue LoadError => e
    puts "gem could not be required: pry-clipboard"
  end

  begin
    require 'awesome_print'
    Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
  rescue LoadError => e
    puts "gem could not be required: awesome_print"
  end
end

require 'gist'

# === CUSTOM COMMANDS ===
# from: https://gist.github.com/1297510
default_command_set = Pry::CommandSet.new do

  command "copy", "Copy argument to the clip-board" do |str|
     IO.popen('xclip', 'w') { |f| f << str.to_s }
  end

  command "clear" do
    system 'clear'
    if ENV['RAILS_ENV']
      output.puts "Rails Environment: " + ENV['RAILS_ENV']
    end
  end

  command "sql", "Send sql over AR." do |query|
    if ENV['RAILS_ENV'] || defined?(Rails)
      pp ActiveRecord::Base.connection.select_all(query)
    else
      pp "No rails env defined"
    end
  end

  command "caller_method" do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
      file   = Regexp.last_match[1]
      line   = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end
end

Pry.config.commands.import default_command_set

MY_HOOK = Pry::Hooks.new.add_hook(:before_session, :add_dirs_to_load_path) do
  # adds the directories /spec and /test directories to the path if they exist and not already included
  dir = `pwd`.chomp
  dirs_added = []
  %w(spec test).map{ |d| "#{dir}/#{d}" }.each do |p|
    if File.exist?(p) && !$:.include?(p)
      $: << p
      dirs_added << p
    end
  end
  puts "Added #{ dirs_added.join(", ") } to load path in ~/.pryrc." if dirs_added.present?
end

MY_HOOK.exec_hook(:before_session)

if File.exist?('rails') && ENV['SKIP_RAILS'].nil?
    if require('rails') && defined?(Rails)
      if Rails.version[0..0] == "2"
        require 'console_app'
        require 'console_with_helpers'
      elsif Rails.version[0..0] == "3"
        require 'rails/console/app'
        require 'rails/console/helpers'
      else
        warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
      end
    end
    if defined?(Rails) && Rails.env
      begin
        extend Rails::ConsoleMethods
      rescue => e
        puts "error extending rails console methods: #{ e.message }"
      end
    end
end


# # === COLOR CUSTOMIZATION ===
# # Everything below this line is for customizing colors, you have to use the ugly
# # color codes, but such is life.
# CodeRay.scan("example", :ruby).term # just to load necessary files
# # Token colors pulled from: https://github.com/rubychan/coderay/blob/master/lib/coderay/encoders/terminal.rb
# TERM_TOKEN_COLORS = {
#         :attribute_name => '33',
#         :attribute_value => '31',
#         :binary => '1;35',
#         :char => {
#           :self => '36', :delimiter => '34'
#         },
#         :class => '1;35',
#         :class_variable => '36',
#         :color => '32',
#         :comment => '37',
#         :complex => '34',
#         :constant => ['34', '4'],
#         :decoration => '35',
#         :definition => '1;32',
#         :directive => ['32', '4'],
#         :doc => '46',
#         :doctype => '1;30',
#         :doc_string => ['31', '4'],
#         :entity => '33',
#         :error => ['1;33', '41'],
#         :exception => '1;31',
#         :float => '1;35',
#         :function => '1;34',
#         :global_variable => '42',
#         :hex => '1;36',
#         :include => '33',
#         :integer => '1;34',
#         :key => '35',
#         :label => '1;15',
#         :local_variable => '33',
#         :octal => '1;35',
#         :operator_name => '1;29',
#         :predefined_constant => '1;36',
#         :predefined_type => '1;30',
#         :predefined => ['4', '1;34'],
#         :preprocessor => '36',
#         :pseudo_class => '34',
#         :regexp => {
#           :self => '31',
#           :content => '31',
#           :delimiter => '1;29',
#           :modifier => '35',
#           :function => '1;29'
#         },
#         :reserved => '1;31',
#         :shell => {
#           :self => '42',
#           :content => '1;29',
#           :delimiter => '37',
#         },
#         :string => {
#           :self => '36',
#           :modifier => '1;32',
#           :escape => '1;36',
#           :delimiter => '1;32',
#         },
#         :symbol => '1;31',
#         :tag => '34',
#         :type => '1;34',
#         :value => '36',
#         :variable => '34',

#         :insert => '42',
#         :delete => '41',
#         :change => '44',
#         :head => '45'
# }

# module CodeRay
#     module Encoders
#         class Terminal < Encoder
#             # override old colors
#             TERM_TOKEN_COLORS.each_pair do |key, value|
#                 TOKEN_COLORS[key] = value
#             end
#         end
#     end
# end

#
# jheidt's kickass pry config
#

# Pry.editor = proc { |file, line| "/usr/bin/subl #{file} +#{line}" }
# Pry.config.theme = 'tomorrow'

# Pry.config.ls.heading_color          = :white
# Pry.config.ls.class_constant_color   = :bright_green
# Pry.config.ls.instance_var_color     = :bright_blue
# Pry.config.ls.protected_method_color = :bright_black
# Pry.config.ls.private_method_color   = :yellow

# def colour(name, text)
#   if RUBY_PLATFORM =~ /java/
#     Pry.color ? "#{Pry::Helpers::Text.send name, '{text}'}".sub('{text}', "#{text}") : text
#   else
#     Pry.color ? "\001#{Pry::Helpers::Text.send name, '{text}'}\002".sub('{text}', "\002#{text}\001") : text
#   end
# end

# Pry.config.prompt = [
#   proc do |object, nest_level, pry|
#     prompt  = colour :bright_black, Pry.view_clip(object)
#     prompt += ":" if nest_level > 0
#     prompt += colour :bright_cyan, "#{nest_level}" if nest_level > 0
#     prompt += colour :cyan, ' » '
#   end, proc { |object, nest_level, pry| colour :cyan, '» ' }
# ]

# begin
#   #require 'hirb'
#   require 'hirb-unicode'

#   Hirb.enable

#   old_print = Pry.config.print
#   Pry.config.print = proc do |*args|
#     Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
#   end
# rescue LoadError
#   #...
# end

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

# Log Rails stuff like SQL/Mongo queries to $stdout if in Rails console

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