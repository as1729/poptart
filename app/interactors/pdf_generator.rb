module PdfGenerator
    require "prawn/measurement_extensions"
  def self.generate_pdf(data = nil)
    data ||= self.sample_data
    height = 80 + (data[:calendar_items].count * 20)
    pdf = Prawn::Document.new(page_size: [56.mm, height.mm], margin: 2.mm)
    jw_logo = "#{Rails.root}/app/assets/images/jw_logo.png"
    pdf.image( jw_logo, at: [18.mm,(height - 18).mm], width: 20.mm)

    employee_details = data[:employee_details]
    pdf.default_leading = 1.mm
    pdf.font("#{Rails.root}/app/assets/fonts/Courier.ttf")
    pdf.font_size = 8
    pdf.y = (height - 40).mm
    pdf.text(employee_details[:organization], align: :center)
    pdf.text(employee_details[:name], align: :center)
    pdf.text(employee_details[:team], align: :center)
    pdf.text(data[:calendar_date].strftime('%a %b %d'), align: :center)
    pdf.move_down(5.mm)
    pdf.line_width = 1
    pdf.stroke_horizontal_rule
    pdf.move_down(5.mm)

    data[:calendar_items].each do |item|
      self.draw_cal_item(item, pdf)
      pdf.move_down(5.mm)
    end
    pdf.move_down(5.mm)
    pdf.stroke_horizontal_rule
    pdf.move_down(5.mm)
    pdf.text("How was your day?", align: :center)
    faces = "#{Rails.root}/app/assets/images/faces.png"
    pdf.image( faces, at: [3.mm, 23.mm], width: 46.mm)
    pdf.move_down(15.mm)
    pdf.text("Created with Dailypop", align: :center)
    pdf.text("***", align: :center)

    pdf.render_file('daily_pop.pdf')

  end

  def self.draw_cal_item(calendar_item, pdf)
    style = []
    if calendar_item[:current_rsvp] == "N"
      style << :bold
    end
    pdf.text(calendar_item[:event_name])
    if calendar_item[:all_day]
      pdf.move_up 3.mm
      pdf.text("All Day", { align: :right })
    else
      pdf.move_up 3.mm
      pdf.text(calendar_item[:time].strftime('%l:%M %p'), { align: :right })
    end
    pdf.text("#{calendar_item[:location]}") if calendar_item[:location]
    if calendar_item[:current_rsvp] == "M"
      pdf.text("RSVP: ☐ YES ☐ NO")
    end
  end

  def self.sample_data
    {
      employee_details: {
        name: "Matyus",
        desk_title: "Software engieer",
        team: "Benefits Extra",
        organization: "Justworks"
      },
      calendar_date: Time.zone.today,
      calendar_items: [
        {
          event_name: "Brandon PTO",
          all_day: true,
        },
        {
          event_name: "Matyus / Julia 1:1",
          current_rsvp: "Y",
          location: "\t11th Ave G5:\n\tGoldenrod Blobfish\n\t(4)",
          time: Time.zone.now
        },
        {
          event_name: "Codebase Overview",
          current_rsvp: "N",
          location: "11th Ave G5",
          time: Time.zone.now
        },
        {
          event_name: "Copy Corner",
          current_rsvp: "M",
          location: "\t11th Ave G5 - D5:\n\tDenim Wren (10)",
          time: Time.zone.now
        }
      ]
    }
  end
end
