# frozen_string_literal: true

class BaseCommand
  include ClassMethodize
  include Rake::FileUtilsExt

  def run(*args)
    command = Shellwords.join(args.compact)

    puts "$ #{command}"

    if block_given?
      system(command)
      yield
    else
      is_ok = system(command)
      raise "command failed" unless is_ok
    end
  end

  def simple_run(command)
    puts "$ #{command}"
    system(command)
  end

  def python(*args)
    run("python", *args)
  end
end
