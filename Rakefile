require "bundler"
Bundler.setup

gemspec = eval(File.read("core-data-parser.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["core-data-parser.gemspec"] do
  system "gem build core-data-parser.gemspec"
end
