#!/bin/bash
# dialog.sh: Using 'gdialog' widgets.
# Must have 'gdialog' installed on your system to run this script.

# This script was inspired by the following article.
#     "Scripting for X Productivity," by Marco Fioretti,
#      LINUX JOURNAL, Issue 113, September 2003, pp. 86-9.
# Thank you, all you good people at LJ.


# Input error in dialog box.
E_INPUT=65
# Dimensions of display, input widgets.
HEIGHT=50
WIDTH=60

# Output file name (constructed out of script name).
OUTFILE=$0.output

# Display this script in a text widget.
gdialog --title "Displaying: $0" --textbox $0 $HEIGHT $WIDTH


# Now, we'll try saving input in a file.
echo -n "VARIABLE=\"" > $OUTFILE   # Quote it, in case of whitespace
                                   #+ in the input.
gdialog --title "User Input" --inputbox "Enter variable, please:" \
$HEIGHT $WIDTH 2>> $OUTFILE


if [ "$?" -eq 0 ]
# It's good practice to check exit status.
then
  echo "Executed \"dialog box\" without errors."
else
  echo "Error(s) in \"dialog box\" execution."
        # Or, clicked on "Cancel", instead of "OK" button.
  rm $OUTFILE
  exit $E_INPUT
fi


echo -n "\"" >> $OUTFILE           # End quotes on saved variable.
#  This command stuck down here in order not to mess up
#+ exit status, above.


# Now, we'll retrieve and display the saved variable.
. $OUTFILE   # 'Source' the saved file.
echo "The variable input in the \"input box\" was: "$VARIABLE""

rm $OUTFILE  # Clean up by removing the temp file.
             # Some applications may need to retain this file.

exit 0
