include Java

import javax.swing.JFrame
import javax.swing.JComboBox
import javax.swing.JButton
import javax.swing.JPanel
import javax.swing.JLabel
import javax.swing.JTextField

import java.awt.GridLayout

class NumberConverter < JFrame
  NUM_FORMATS = {"Decimal" => 10, "Binary" => 2, "HexaDecimal" => 16, "Octal" => 8}

  def initialize
    super('Number Format Converter')

    main = JPanel.new
    main.set_layout(GridLayout.new(3,3,2,2))

    main.add(JLabel.new("Convert From : ", JLabel::RIGHT))
    main.add(cmbFrom = JComboBox.new)

    main.add(input = JTextField.new(15))

    main.add(JLabel.new("Convert To : ", JLabel::RIGHT))
    main.add(cmbTo = JComboBox.new)
    main.add(result = JTextField.new(15))
    result.set_editable(false)

    main.add(JLabel.new(" ")); # Leave 1 grid cell blank

    main.add(btn = JButton.new("CONVERT"))
    btn.add_action_listener do
      format_from = cmbFrom.get_selected_item.to_s
      format_to = cmbTo.get_selected_item.to_s
      number = input.get_text

      result.set_text(convert(format_from, format_to, number))
    end

    NUM_FORMATS.keys.each do |format|
      cmbFrom.add_item format
      cmbTo.add_item format
    end

    get_content_pane().add("Center", main)
    get_content_pane().add("South", JLabel.new("<html><br /><p style=\"color: red; font-size:8px\">Don't use fractions</p></html>", JLabel::CENTER))

    set_size(400,140)
    set_visible(true)
    set_default_close_operation(JFrame::EXIT_ON_CLOSE)
  end

  def convert(format_from, format_to, number)
    radix = NUM_FORMATS[format_from]

    #Convert input to an int
    number = number.to_i(radix)

    #Convert the int to specified format
    number.to_s(NUM_FORMATS[format_to]).upcase
  end

end

NumberConverter.new
