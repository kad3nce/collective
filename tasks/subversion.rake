desc "Add new files to subversion"
task :svn_add do
   system "svn status | grep '^\?' | sed -e 's/? *//' | sed -e 's/ /\ /g' | xargs svn add"
end