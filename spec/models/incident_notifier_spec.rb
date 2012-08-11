require 'spec_helper'

describe IncidentNotifier do
  
  it "should call the notifiers notify method when sending" do
    incident = "my incident"
    notifier_mock = mock('notifier')
    notifier_mock.should_receive(:notify).with(incident)
    notifier = IncidentNotifier.new()
    notifier.stub(:get_notifiers).and_return([notifier_mock].map {|n| (n.method :notify) })
    notifier.notify(incident)
  end
  
  it "should call each notifer implementation when sending when there are multiple notifiers" do
    incident = "my incident"
    notifier_mock1 = mock('notifier1')
    notifier_mock2 = mock('notifier2')
    notifier_mock3 = mock('notifier3')
    notifier_mock1.should_receive(:notify).with(incident)
    notifier_mock2.should_receive(:notify).with(incident)
    notifier_mock3.should_receive(:notify).with(incident)
    notifier = IncidentNotifier.new()
    notifier.stub(:get_notifiers).and_return([notifier_mock1,notifier_mock2,notifier_mock3].map {|n| (n.method :notify) })
    notifier.notify(incident)
  end
  
end