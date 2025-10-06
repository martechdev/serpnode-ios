Pod::Spec.new do |s|
  s.name             = 'Serpnode'
  s.version          = '0.1.0'
  s.summary          = 'Swift client for serpnode.com API.'
  s.description      = 'Search Google SERP data via serpnode. See https://serpnode.com/docs/'
  s.homepage         = 'https://serpnode.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EverAPI' => 'support@serpnode.com' }
  s.source           = { :git => 'https://github.com/martechdev/serpnode-ios.git', :tag => s.version.to_s }
  s.swift_version    = '5.9'
  s.ios.deployment_target = '12.0'
  s.macos.deployment_target = '10.15'
  s.source_files     = 'Sources/**/*.{swift}'
  s.frameworks       = 'Foundation'
end


