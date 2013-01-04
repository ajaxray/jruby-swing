include Java

import javax.swing.JFrame
import javax.swing.JComboBox
import javax.swing.JButton
import javax.swing.JPanel
import javax.swing.JLabel
import javax.swing.JTextField

import java.awt.GridLayout

class NumberConverter < JFrame

	def initialize
		super('Number Format Converter')

		main = JPanel.new;
		main.set_layout(GridLayout.new(3,3,2,2))
		
		main.add(JLabel.new("Convert From : ", JLabel::RIGHT));
	    main.add(@cmbFrom = JComboBox.new);
	    
	    main.add(@input = JTextField.new(15));
	    
	    main.add(JLabel.new("Convert To : ", JLabel::RIGHT));
		main.add(@cmbTo = JComboBox.new);
		# 'result' is not being accessed from outside this function. So, leaving in function scope. 
	    # not declearing with @
		main.add(result = JTextField.new(15));
		result.set_editable(false);
		
		main.add(JLabel.new(" ")); # Leave 1 grid cell blank
		main.add(btn = JButton.new("CONVERT"));
		btn.add_action_listener do |evt|
			result.set_text(convert.upcase);
		end
		
		num_formats = ["Decimal", "Binary", "HexaDecimal", "Octal"]
		num_formats.each{|format| @cmbFrom.add_item format}
		num_formats.each{|format| @cmbTo.add_item format}

		get_content_pane().add("Center", main);
		get_content_pane().add("South", JLabel.new("<html><br /><p style=\"color: red; font-size:8px\">Don't use fractions</p></html>", JLabel::CENTER));

		set_size(400,140);
		set_visible(true);
		set_default_close_operation(JFrame::EXIT_ON_CLOSE);
	end
	
	def convert
		radix = 10
		
		#Get the radix of input
		case @cmbFrom.get_selected_item.to_s
			when "Binary"; 	  	radix = 2
			when "HexaDecimal"; radix = 16
			when "Octal"; 		radix = 8 	
		end

		#Convert input to an int
		num = @input.get_text.to_i(radix);
		
		#Convert the int to specified format
		case @cmbTo.get_selected_item.to_s
			when "Decimal";     output = num.to_s
			when "Binary"; 	    output = num.to_s(2)
			when "HexaDecimal"; output = num.to_s(16)
			when "Octal";       output = num.to_s(8)
		end

		output;
	end

end

num_conv = NumberConverter.new
