module PdfGenerator
    require "prawn/measurement_extensions"
  def self.generate_pdf(data)
    height = 200 + (data[:calendar_items].count * 20)
    pdf = Prawn::Document.new(page_size: [50.mm, height.mm], margin: 0)
    pdf.text("Dailypop")
    pdf.render_file('daily_pop.pdf')
  end

  def self.sample_data
    {
      employee_details: {
        name: "Matyus",
        desk_title: "Software engieer",
        team: "Ben Xtra",
        organization: "Justworks"
      },
      calendar_items: [
        {
          event_name: "Brandon PTO",
          all_day: true,
        },
        {
          event_name: "Standup",
          current_rsvp: "Y", # can be 'N' or 'M'
          location: "11th Ave G5"
        }
      ]
    }
  end
end
