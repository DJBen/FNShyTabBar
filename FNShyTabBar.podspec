Pod::Spec.new do |s|
  s.name             = "FNShyTabBar"
  s.version          = "0.2.0"
  s.summary          = "A shy tab bar that hides as you swipe up the content, which allows the screen to display more information."
  s.description      = <<-DESC
                       A shy tab bar that hides as you swipe up the content, giving users more space of the content. Perfect if coupled with `SQTShyNavigationBar`.
                       DESC
  s.homepage         = "https://github.com/DJBen/FNShyTabBar"
  s.license          = 'WTFPL'
  s.author           = { "DJBen" => "lsh32768@gmail.com" }
  s.source           = { :git => "https://github.com/DJBen/FNShyTabBar.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'FNShyTabBar' => ['Pod/Assets/*.png']
  }
end
