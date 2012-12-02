task :default => [:main]

task :main do
	ruby 'resolve_dependency.rb'
	`dot -Tpng -O1.png diagram.dot`
end