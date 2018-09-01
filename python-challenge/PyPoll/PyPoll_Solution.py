
# coding: utf-8

# In[55]:


import os
import csv
PyPoll_csv = os.path.join("Resources", "election_data.csv")

Total_Votes = 0
Total_Candidates = 0
Winner = ""
max_votes = 0
Candidate_Votes = {}

with open(PyPoll_csv) as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")
    
    header = next(csvreader)
    for row in csvreader:
        Total_Votes = Total_Votes + 1
        Total_Candidates = row[2]
        if row[2] not in Candidate_Votes:
            Candidate_Votes[row[2]] = 1
        else:
            Candidate_Votes[row[2]] = Candidate_Votes[row[2]] + 1
    
    print("Election Results")
    print("-------------------------")
    print("Total Votes: " + str(Total_Votes))
    print("-------------------------")
    for k,v in Candidate_Votes.items():
        percentage_votes = (v/Total_Votes)*100
        if v > max_votes:
            max_votes = v
            Winner = k
        print(k + ": " + str(round(percentage_votes, 3)) + "% (" + str(v) + ")")
    print("-------------------------")
    print("Winner: " + Winner)
    print("-------------------------")
    
PyPoll_csv = ("Resources", "election_data.csv")
PyPoll_text = os.path.join("Election_Results.txt")

with open(PyPoll_text, "w") as txt_file:
    txt_file.write("Election Results")
    txt_file.write("\n")
    txt_file.write("-------------------------")
    txt_file.write("\n")
    txt_file.write("Total Votes: " + str(Total_Votes))
    txt_file.write("\n")
    txt_file.write("-------------------------")
    txt_file.write("\n")
    for k,v in Candidate_Votes.items():
        percentage_votes = (v/Total_Votes)*100
        if v > max_votes:
            max_votes = v
            Winner = k
        txt_file.write(k + ": " + str(round(percentage_votes, 3)) + "% (" + str(v) + ")")
        txt_file.write("\n")
    txt_file.write("-------------------------")
    txt_file.write("\n")
    txt_file.write("Winner: " + Winner)
    txt_file.write("\n")
    txt_file.write("-------------------------")
    txt_file.write("\n")
    

