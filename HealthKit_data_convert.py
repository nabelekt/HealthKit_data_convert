# Copyright (c) Thomas Nabelek. All rights reserved.
# This file is part of the HealthKit_data_convert project.
#
# HealthKit_data_convert is free software: you can redistribute it and/or modify
# it under the terms of version 3 of the GNU General Public License as published
# by the Free Software Foundation.
#
# HealthKit_data_convert is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.


import sys

# Check if correct number of input argments were given, exit if not
if len(sys.argv) < 3:
  exit(f"\nERROR: File names not specified. Usage: {sys.argv[0]} [input_file.xml] [output_file.csv]\nExiting.\n\n")

# List types of records to search for
record_types = ["HKQuantityTypeIdentifierHeartRate"]
keys = ['startDate', 'value', 'unit']


# Open data file
try:
  input_data_file = open(sys.argv[1], "r")
except:
  exit(f"\nERROR: Specified file {sys.argv[1]} could not be opened.\nExiting.\n\n")

extracted_data = []

# Go line-by-line through data file
for line in input_data_file:
  if line.startswith(f' <Record type="{record_types[0]}"') :

    line_data = []
    for key in keys:
      key = key + '="'
    
      starting_ind = line.find(key) + len(key)

      value = ""
      for char in line[starting_ind:]:
        if char is not '"':  # Collect all characters until the closing quotation mark
          value = value + char
        else:  # When the closing quotation mark is encountered, exit loop
           break

      # Keep timestamp and data value together
      line_data.append(value)

    # Add timestamp and data value pair to rest of data
    extracted_data.append(line_data)

# Open output file and write CSV data
output_file = open(sys.argv[2], "w")


output_file.write(f"DateTime, HeartRate, unit,\n")
for element in extracted_data:
  output_file.write(f"{element[0]}, {element[1]}, {element[2]}\n")

exit(f"\nOutput file {sys.argv[2]} saved.\nExiting.\n\n")