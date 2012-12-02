require 'rexml/document'

def get_component_id (xml_element)
	"#{xml_element.get_text('groupId')}.#{xml_element.get_text('artifactId')}"
end

def	find_dependencies (pom_filename)
	dependencies = []

	pom = File.read(pom_filename);
	xml = REXML::Document.new(pom)
	root = nil
	xml.elements.each('project') do |project|
		root = get_component_id(project)
	end

	xml.elements.each('project/dependencies/dependency') do	|dependency|
		id = get_component_id(dependency)
		scope = dependency.get_text('scope') || 'compile'
		dependencies << {
			:from => id,
			:to => root,
			:scope => scope
		}
	end
	
	dependencies
end

def	output(dependencies, except)
	ans = ''
	dependencies.each do |dependency|
		next if except.include?(dependency[:from].to_s) || except.include?(dependency[:to].to_s)
		ans = ans + "\t\"#{dependency[:from]}\" -> \"#{dependency[:to]}\" [label=\"#{dependency[:scope]}\"];\n"
	end
	ans = "digraph G{\n#{ans}}"
	File.open('diagram.dot', 'w') do |file|
		file.puts(ans);
	end
end

EXCEPT = [
	'com.oocl.sps.sfp_used',
	'com.oocl.sps.ext_libs',
	'com.bea.core.utils',
	'com.bea.core.management.core',
	'com.bea.core.descriptor',
	'com.bea.core.i18n',
	'com.bea.core.utils.classloaders'
]

PATH = '**\pom.xml'.gsub('\\','/')

dependencies = []
Dir.glob(PATH).each do |pom_filename|
	dependencies = dependencies + find_dependencies(pom_filename)
end
output(dependencies, EXCEPT)