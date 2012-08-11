class IncidentNotifier
  #TODO need to figure out how to inject notifieres (email, pusher etc) into this Domain event handler
  # we may not need to pass in actual types as we are just passing off the incident so a list of focuntions could be ok?
  #would also like this to be done on a background thread longterm to avoid long page loads for the user
  def notify(incident)
    for n in get_notifiers
      n.(incident)
    end
  end
  
  def get_notifiers
    funcs = []
    funcs << Proc.new { |incident| IncidentMailer.distress_email(incident).deliver  }
    funcs
  end 
end