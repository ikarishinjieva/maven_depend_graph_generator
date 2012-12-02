maven_depend_graph_generator
============================
# Preview
![output](https://github.com/ikarishinjieva/maven_depend_graph_generator/blob/master/diagram.dot.png)
# Feature
1. Could include multiple pom files
2. Could ignore some of artifacts, you can specific the ignore list
# HOW to use
1. Install a dot graph generator. Recommand [Graphviz](http://graphviz.org)
2. Make sure you have a ruby and rake installed.
3. In resolve_dependency.rb
	* specific PATH to your POM files.
	* specific EXCEPT the artifacts you want to ignored.
4. run 'rake'