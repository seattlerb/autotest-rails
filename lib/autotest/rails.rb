require 'autotest'

class Autotest::Rails < Autotest
  VERSION = '4.2.1'

  def initialize # :nodoc:
    super

    add_exception %r%^\./(?:db|doc|log|public|script|tmp|vendor)%

    clear_mappings

    add_mapping %r%^lib/(.*)\.rb$% do |_, m|
      files_matching %r%^test/(lib|unit/lib)/#{m[1]}.*_test.rb$%
      # TODO: (unit|functional|integration) maybe?
    end

    add_mapping %r%^test/fixtures/(.*)s.yml% do |_, m|
      files_matching %r%^test/(models|controllers|views|unit|functional)/#{m[1]}.*_test.rb$%
    end

    add_mapping %r%^test/.*_test\.rb$% do |filename, _|
      filename
    end

    add_mapping %r%^app/models/(.*)\.rb$% do |_, m|
      files_matching %r%^test/(models|unit)/#{m[1]}.*_test.rb$%
    end

    add_mapping %r%^app/helpers/(.*)_helper.rb% do |_, m|
      if m[1] == "application" then
        files_matching %r%^test/(helpers|controllers|views|unit/helpers/functional)/.*_test\.rb$%
      else
        files_matching %r%^test/(helpers|controllers|views|unit/helpers/functional)/#{m[1]}.*_test.rb$%
      end
    end

    add_mapping %r%^app/views/(.*)/% do |_, m|
      files_matching %r%^test/(controllers|views|functional)/#{m[1]}.*_test.rb$%
    end

    add_mapping %r%^app/controllers/(.*)\.rb$% do |_, m|
      if m[1] == "application" then
        files_matching %r%^test/(controllers|views|functional)/.*_test\.rb$%
      else
        files_matching %r%^test/(controllers|views|functional)/#{m[1]}.*_test.rb$%
      end
    end

    add_mapping %r%^app/views/layouts/% do
      "test/views/layouts_view_test.rb"
    end

    add_mapping %r%^test/test_helper.rb|config/((boot|environment(s/test)?).rb|database.yml|routes.rb)% do
      files_matching %r%^test/(models|controllers|views|unit|functional)/.*_test.rb$%
    end
  end

  # Convert the pathname s to the name of class.
  def path_to_classname(s)
    sep = File::SEPARATOR
    f = s.sub(/^test#{sep}((\w+)#{sep})?/, '').sub(/\.rb$/, '').split(sep)
    f = f.map { |path| path.split(/_/).map { |seg| seg.capitalize }.join }
    f = f.map { |path| path =~ /Test$/ ? path : "#{path}Test"  }
    f.join('::')
  end
end
