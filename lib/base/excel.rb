# encoding: UTF-8
# $Id: excel.rb 441 2016-05-25 17:05:30Z e0c2507 $
require 'rubyXL'
require 'yaml'
require 'pathname'

##
# This class converts excel file to yml file.
# It generates .yml file for each worksheet.
class Excel
  @excel_file
  #
  # Convert each worksheet into a yml file.
  def read_excel_file(file_loc)
    file_loc = file_exists(file_loc)
    $excel_file = file_exists(file_loc)
    puts "=====#{@excel_file}"
    workbook = RubyXL::Parser.parse(file_loc)
    workbook.worksheets.count.times do |k|
      @test_data = {}
      convert_excel_to_yml(workbook[k])
      write_to_file(workbook[k], file_loc)
    end
  end

  #
  # Check if file exists and get the absolute path of the file if it exists.
  def file_exists(file_loc)
    puts "====file exists======="
    #
    #  Check if its abs or rel path
    unless Pathname.new(file_loc).absolute? then
      file_loc = File.join(SAF::DATA_EXCEL, file_loc)
    end
    unless File.file?(file_loc)
      raise "File doesn't exist."
    end
    return file_loc
  end

  ##
  # Load worksheet data into a hash
  def convert_excel_to_yml(workbook)
    puts "====covertexcelt ot yml"
    (workbook.count - 1).times do |i|
      row = workbook.sheet_data[i + 1]
      ##
      # Added if just to make sure that there is a test id
      # because sometimes rubyXL treats spaces as rows
      # and thinks that there is some data
      # this depends on how the excel file was formatted
      next if row[0].nil?
      convert_single_row(workbook.sheet_data, row)
    end
  end

  ##
  # Converts a single row in an excel spreadsheet to our yml hash.
  def convert_single_row(sheet_data, row)
    col = 0
    @test_data[row[0].value] = {}
    until sheet_data[0][col += 1].nil? do
      convert_single_cell(sheet_data, row, col)
    end
  end

  ##
  # Moves over a single cell from an excel sheet to the yml hash.
  def convert_single_cell(sheet_data, row, col_number)
    test_id = row[0].value
    key = sheet_data[0][col_number].value
    cell = row[col_number]
    @test_data[test_id][key] = cell.nil? ? nil : cell.value
  end

  ##
  # Write to a yml file and delete if one already exists with the same name
  def write_to_file(workbook, file_loc)
    yml_file = File.join(SAF::DATA_YML, "#{workbook.sheet_name}.yml")
    File.open(yml_file, "w") do |file|
      file.puts("#Workbook: " + file_loc)
      file.puts("#Worksheet: " + workbook.sheet_name)
      file.puts(@test_data.to_yaml)
    end
  end

  ##
  #Check if all the YML files are generated
  def check_yml_files
    puts "--check yml file--"
    # @file_loc = file_exists(file_loc)
    workbook = RubyXL::Parser.parse(@excel_file)
    puts workbook.count
    # @workbook.worksheets.count.times do |k|
    #   file = File.join(SAF::DATA_YML, "#{k.sheet_name}.yml")
    #   unless File.file?(file)
    #     raise "File doesn't exist."
    #   end
    # end
  end
end
