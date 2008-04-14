namespace :ditz do
  
  desc "Show current issue status overview"
  task :status do
    system 'ditz status'
  end
  desc "Show currently open issues"
  task :todo do
    system 'ditz todo'
  end
  desc "Show recent issue activity"
  task :log do
    system 'ditz log'
  end
  
  # desc "Generate issues to meta/issues"
  task :html do
    # `'d instead of system'd, because I don't want that output cluttering shit
    `ditz html meta/issues`
  end
  # desc "Opens meta/issues in your main browser, if you are using a Macintosh"
  task :'html:open' do
    system 'open ' + :meta / :issues / 'index.html' if PLATFORM['darwin']
  end
  
  # protip: Create a bash alias for this!
  desc "Stage all issues to git (always run before commiting!)"
  task :stage do
    system 'git-add bugs/'
  end
end