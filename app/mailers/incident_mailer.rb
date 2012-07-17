class IncidentMailer < ActionMailer::Base
  default :from => "trixie.development@trixie.com"

  def distress_email(incident)
    @incident = incident
    @distressed_person = incident.user
    @heading = "#{@distressed_person.name} is in distress"
    emails = @distressed_person.emergency_contacts.map {|ec| "#{ec.name} <#{ec.email}>" }
    mail(:to => emails, :subject => @heading)
  end
end

# http://maps.google.com/maps/api/staticmap?size=300x300&maptype=roadmap&sensor=false&markers=color:red%7C51.45976,-0.001096&client=google-maps-sharing&signature=5RGcT2oD4WKEddRNWWJ86m0cZ2Q=

# http://maps.google.com/maps/api/staticmap?
# => size=300x300&
# => maptype=roadmap&
# => sensor=false&
# => markers=color:red%7C51.45976,-0.001096&
# => client=google-maps-sharing&
# => signature=5RGcT2oD4WKEddRNWWJ86m0cZ2Q=
