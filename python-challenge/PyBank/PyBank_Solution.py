
# coding: utf-8

# In[11]:


import os
import csv
PyBank_csv = os.path.join("Resources", "budget_data.csv")

Total_Months = 0
Total_Net_Amount = 0
Total_Change = 0
Average_Change = []
Greatest_Increase_in_Profits = 0
Greatest_Increase_Month = []
Greatest_Decrease_in_Profits = 0
Greatest_Decrease_Month = []

with open(PyBank_csv) as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")

    header = next(csvreader)
    prev_value = 0
    for row in csvreader:
        if Total_Months > 0:
            net_change = int(row[1]) - prev_value
            Total_Change = Total_Change + (int(row[1]) - prev_value)
            if net_change > Greatest_Increase_in_Profits:
                Greatest_Increase_in_Profits = net_change
                Greatest_Increase_Month = row[0]
            if net_change < Greatest_Decrease_in_Profits:
                Greatest_Decrease_in_Profits = net_change
                Greatest_Decrease_Month = row[0]
        prev_value = int(row[1])
        Total_Months = Total_Months + 1
        Total_Net_Amount = Total_Net_Amount + int(row[1])
    Average_Change = Total_Change/(Total_Months-1)

    print("Financial Analysis")
    print("----------------------------")
    print("Total Months: " + str(Total_Months))
    print("Total Net Amount: $" + str(Total_Net_Amount))
    print("Average Change: $" + str('{number:.{digits}f}'.format(number=Average_Change, digits=2)))
    print("Greatest Increase in Profits: " + str(Greatest_Increase_Month) + " ($" + str(Greatest_Increase_in_Profits) +")")
    print("Greatest Decrease in Profits: " + str(Greatest_Decrease_Month) + " ($" + str(Greatest_Decrease_in_Profits) +")")

PyBank_csv = ("Resources", "budget_data.csv")
PyBank_text = os.path.join("Financial_Analysis.txt")

with open(PyBank_text, "w") as txt_file:
    txt_file.write("Financial Analysis")
    txt_file.write("\n")
    txt_file.write("----------------------------")
    txt_file.write("\n")
    txt_file.write("Total Months: " + str(Total_Months))
    txt_file.write("\n")
    txt_file.write("Total Net Amount: $" + str(Total_Net_Amount))
    txt_file.write("\n")
    txt_file.write("Average Change: $" + str('{number:.{digits}f}'.format(number=Average_Change, digits=2)))
    txt_file.write("\n")
    txt_file.write("Greatest Increase in Profits: " + str(Greatest_Increase_Month) + " ($" + str(Greatest_Increase_in_Profits) +")")
    txt_file.write("\n")
    txt_file.write("Greatest Decrease in Profits: " + str(Greatest_Decrease_Month) + " ($" + str(Greatest_Decrease_in_Profits) +")")
    txt_file.write("\n")
    

