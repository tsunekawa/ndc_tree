# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ndc_tree"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mao Tsunekawa"]
  s.date = "2012-02-02"
  s.description = "NdcTree is a library outputs a list of NDC(Nippon Decimal Classification) as a tree-structured data."
  s.email = "tsunekaw@slis.tsukuba.ac.jp"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
  ]
  s.files = [
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "example/graph.rb",
    "lib/ndc_tree.rb",
    "lib/ndc_tree/node.rb",
    "lib/ndc_tree/version.rb",
    "ndc_tree.gemspec",
    "spec/ndc_tree_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/tsunekawa/ndc_tree"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "NdcTree is a library outputs a list of NDC(Nippon Decimal Classification) as a tree-structured data"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubytree>, [">= 0.8.1"])
      s.add_runtime_dependency(%q<ruby-graphviz>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rubytree>, [">= 0.8.1"])
      s.add_dependency(%q<ruby-graphviz>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rubytree>, [">= 0.8.1"])
    s.add_dependency(%q<ruby-graphviz>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

