class RecentUpdatesPart < Merb::PartController
  
  def index
    @versions = Version.recent
    display @versions
  end
  
end
