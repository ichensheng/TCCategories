Pod::Spec.new do |s|
  s.name         = "TCCategories"
  s.version      = "0.1"
  s.summary      = "常用category"
  s.homepage     = "https://github.com/ichensheng/TCCategories"
  s.license      = "MIT"
  s.author             = { "ichensheng" => "cs200521@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/ichensheng/TCCategories.git", :tag => "0.1" }
  s.source_files  = "TCCategories/Classes/*.{h,m}"
  s.requires_arc = true
  s.dependency "Masonry", "~> 1.0.0"
	s.dependency "JRSwizzle", "~> 1.0"
end
