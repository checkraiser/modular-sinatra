app_dir = File.expand_path("../", File.dirname(__FILE__))
require 'bundler'
Bundler.require(:default)

initializer_files = File.join(app_dir, %w(initializers ** *))
Dir.glob(initializer_files).each {|lf| require lf }

require "#{app_dir}/application"

lib_files = File.join(app_dir, %w(lib ** *))
controller_files = File.join(app_dir, %w(controllers ** *_controller.rb))
model_files = File.join(app_dir, %w(models ** *))


files = [lib_files, model_files, controller_files]

Dir.glob(files).each {|lf| require lf }
