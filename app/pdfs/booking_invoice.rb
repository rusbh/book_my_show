class BookingInvoice < Prawn::Document
  attr_reader :booking

  METADATA = {
    Title: "Booking Invoice",
    Author: "Book My Show",
    Subject: "Booking Confirmation",
    Keywords: "Booking BookMyShow",
    Creator: "Book My Show",
    Producer: "Prawn",
    CreationDate: Time.zone.now,
  }.freeze

  def initialize(booking)
    super(page_size: "A4", margin: 30, info: METADATA)
    @booking = booking
    header
    generate_invoice
    footer
  end

  def generate_invoice
    move_down(10)
    text(
      "Your booking is confirmed!",
      align: :center,
      size: 18,
      color: "4CAF50",
    )
    move_down(10)
    text("Booking ID #{booking.id}", align: :center, size: 16)
    show_details
    order_details
  end

  def header
    repeat(:all) do
      bounding_box([bounds.left, bounds.top], width: bounds.width) do
        text("BookMyShow", align: :center, style: :bold, size: 24)
      end
    end
  end

  def show_poster
    poster = StringIO.open(booking.screening.show.poster.download)
    image(poster, fit: [170, 250])
  end

  def show_details
    bounding_box(
      [bounds.left, bounds.top],
      height: 400,
      width: bounds.width,
    ) do
      bounding_box(
        [bounds.left + 25, bounds.top - 120],
        width: 200,
      ) do
        show_poster
      end
      bounding_box(
        [bounds.left + 225, bounds.top - 125],
        width: 400,
      ) do
        text(booking.screening.show.name.humanize, size: 24)
        move_down(10)
        formatted_text(
          [
            {
              text: booking.show_time.at_timeof.strftime(
                "%I:%M %p",
              ),
            },
            { text: " | " },
            {
              text: booking.booking_date.strftime("%d %B, %Y %A"),
            },
          ],
          size: 14,
        )
        move_down(10)
        text(booking.screening.screen.theater.name.humanize, size: 18)
        move_down(10)
        text(
          "Screen: #{booking.screening.screen.screen_name.humanize}",
          size: 18,
        )
      end
    end
  end

  def order_details
    bounding_box(
      [bounds.left + 25, bounds.bottom + 350],
      height: 400,
      width: bounds.width,
    ) do
      text("Order Summary:", size: 20)
      move_down(10)
      text("Ticket Amount: #{booking.total_price}", size: 16)
      move_down(10)
      text("Quantity: #{booking.ticket} Tickets", size: 16)
      move_down(10)
      text(
        "Booking Date & Time: #{booking.created_at.strftime("%d %B, %Y %A | %I:%M %p")}", size: 14
      )
    end
  end

  def footer
    repeat(:all) do
      bounding_box([bounds.left, bounds.bottom + 25], width: bounds.width) do
        stroke_horizontal_rule
        move_down(10)
        text(
          "© #{Owner.name}",
          align: :center,
          size: 12,
        )
      end
    end
  end
end
