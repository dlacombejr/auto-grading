## Automated grade compiler for CogLab and LearningCataytics into BlackBoard. 

### About

This is a personalized repository for expediting grading into BlackBoard (BB) from external sites like CogLab or LearningCatalytics. The core of the problem is that the lists of students across these websites are not equivalent eliminating the possibility of simple copy and paste. The code in this repository allows for an automatic assignment of scores across different lists with high reliability. Some exceptions need to be made for students that use different first/last names across lists. If used, be sure to ask class to check validity of grades after posting. 

### Files

- `grade_generator.m`
	- Reads in *n* files and generates outputs *n* - 1 files (one originally read file is just for names) with scores based on matches between names. Currenly only supports one score item per spreadsheet but could be easily expanded. 

### Folders

- `grading/`
	- Folder where files to be graded are put

- `graded/`
	- Folder where output files are saved


### Instructions

1. Add the new assignments to be graded by creating their respective columns on BB
2. Download each file that needs to be graded from their respective websites, including an up-to-date spreadsheet from BlackBoard that will be modified and uploaded
3. Copy and change extension of BB file to `.xlsx` using `Save As` (the original download will be the one modified and updated later; this copy is just to retrieve the master name list)
4. Clean up each of the to-be-graded spreadsheets such that the first and second (or only first for CogLab) columns are the names and the third (second for CogLab) column contains the scores; there should be no headers; the spreadsheet from BB can remain unmodified (NOTE: the current implementation can only handle a single grade column per spreadsheet; also the code is buggy if there are empty values at the top or bottom of grade columns - replace with zeros for best performance; script also expects BB file to be last, so must replace first letter with 'x' so it is read last)
5. Place all of the aforementioned spreadsheets (except original `.xls` BB spreadsheet) into `grading/`
6. Run `grade_generator.m`
7. Open the saved `.csv` files and copy the generated grades into the original `.xls` BB spreadsheet
8. Save and upload the BB spreadsheet to BB
9. Remove all files from `grading/` and `graded/` and place in `bin/` by creating subfolder with DD-MM-YY naming convention (`bin/` not in repository due to confidentiality of student names and grades)

___

Any suggestions or comments for improving this workflow are more than welcome. Also feel free to clone this repository for your own grading needs if you use BB. Although this is obviously tailored to my needs, simple modifications should make this useful to anyone that wants to use it. 