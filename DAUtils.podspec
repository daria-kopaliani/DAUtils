Pod::Spec.new do |s|
  s.name         = "DAUtils"
  s.version      = "1.0.1"
  s.summary      = "Utils."
  s.homepage     = "https://github.com/daria-kopaliani/DAUtils.git"
  s.license      = 'MIT'
  s.author       = { "Daria Kopaliani" => "daria.kopaliani@gmail.com" }
  s.source       = { :git => "https://github.com/daria-kopaliani/DAUtils.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'
  s.source_files = 'DAUtils/*.{h,m}'
  s.requires_arc = true
end
