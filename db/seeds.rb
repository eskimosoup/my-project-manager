# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "james@optimised.today", admin: true, password: "james")

["My Office Branding", "My Vehicle Wrap", "Envisage"].each do |brand|
  Brand.create(name: brand)
end

printer_cost = 0.50
ink_cost = 2.50
product_mark_up = 300

products = [
  { name: "Vinyl - Face applied with laminate", description: "Used for externally applied void units/windows, face applied hoardings, foamex, dibond, and sign trays", substrate_cost: 3.85, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Vinyl - Reserse printed, backed with white", description: "For use for void units / windows applied internally", substrate_cost: 2.88, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Floor graphics with laminate", description: "Hard wearing floor graphics", substrate_cost: 4.93, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Poster Paper", description: "Posters. A1 at 0.5 square metres, A0 at 1 square metre", substrate_cost: 1.02, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Banner Material", description: "550gsm strong banner material. Hemmed and supplied with eyelets", substrate_cost: 1.51, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Banner Material - hemmed with eyelets", description: "550gsm strong banner material. Hemmed and supplied with eyelets", substrate_cost: 1.51, hardware_cost: 1.50, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Mesh Banners", description: "Banners with a fine mesh", substrate_cost: 1.51, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Contravision Vinyl", description: "Face applied graphics.  Added to the external of a window.  Restrict viewing from the outside in, but allows to view externally from the outside", substrate_cost: 5.29, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Frosted Vinyl", description: "Used for windows, can be fitted reverse or face applied", substrate_cost: 7.62, mark_up: product_mark_up },
  { name: "Frosted Vinyl - Cut to shape", description: "Cut to shape frosted vinyl for windows. Can be reverse or face applied", substrate_cost: 7.62, hardware_cost: 2.00, mark_up: product_mark_up },
  { name: "Self Cling", description: "Temporary graphics, holds in place by using static.  For use on windows", substrate_cost: 2.03, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Cut Vinyl", description: "Single colour vinyl cut to shape", substrate_cost: 4.26, hardware_cost: 2.50, mark_up: product_mark_up },
  { name: "Printed Vehicle Wrap Vinyl", description: "For vehicle graphics that have a bespoke design", substrate_cost: 12.40, ink_cost: ink_cost, printer_cost: printer_cost, mark_up: product_mark_up },
  { name: "Vehicle Single Colour Vinyl", description: "Single colour vinyl cut to shape", substrate_cost: 7.00, mark_up: product_mark_up }
]

products.each do |p|
  Product.create(p)
end

supporting_products = [
  { name: "Foamex", description: "No print - cut to size and applied", substrate_cost: 6.33, mark_up: 120 },
  { name: "Dibond", description: "No print - cut to size and applied", substrate_cost: 15.00, mark_up: 120 }
]

supporting_products.each do |sp|
  SupportingProduct.create(sp)
end

labours = [
  { name: "Standard Fitting", description: "Price for fitting in normal work hours", per_hour: 15.00, mark_up: 250 },
  { name: "Standard Finishing", description: "Price for finishing in normal work hours", per_hour: 15.00, mark_up: 200 },
  { name: "Out of hours fitting", description: "Price for fitting out of normal hours - Evenings and weekends", per_hour: 25.00, mark_up: 200 }
]

labours.each do |l|
  Labour.create(l)
end
