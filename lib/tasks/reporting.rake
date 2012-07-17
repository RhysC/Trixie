load 'lib/tasks/cucumber.rake'
namespace :reporting do
  @dir = "./progress/"
  Cucumber::Rake::Task.new(:cucumberhtml) do |task|
    task.cucumber_opts = ["--format","html","--out","#{@dir}features.html"]
  end
  
  Spec::Rake::SpecTask.new(:rspechtml) do |t|
    t.spec_opts = ["--format", "html", "-o", "#{@dir}unittests.html"]
    t.fail_on_error = false
  end
  
  task :pendingdevtasks  do 
    system "rake notes >> #{@dir}todos.txt"
  end
  
  task :cleanprogress do
    system "rm #{@dir}*"
  end
  
  task :show do
    system "open -a Google\ Chrome #{@dir}*" #fixme - not working correctly from rake
  end
  
  desc "generate reports of the current developer progress"
  task :progress => ["cleanprogress", "cucumberhtml", "rspechtml", "pendingdevtasks"]#, "show"] 
  
end