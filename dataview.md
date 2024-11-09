
# The Dataview Plugin

<!--toc:start-->
- [The Dataview Plugin](#the-dataview-plugin)
    - [(Pseudo) Random Sorting](#pseudo-random-sorting)
    - [Don't auto-show the file link](#dont-auto-show-the-file-link)
    - [Don't include the current file in your search](#dont-include-the-current-file-in-your-search)
    - [Listing notes with a front-matter due date](#listing-notes-with-a-front-matter-due-date)
    - [Notes created today](#notes-created-today)
<!--toc:end-->

### (Pseudo) Random Sorting
````
```dataview
SORT hash(string(date(today)), text) DESC // Pseudo-random order
// Replace text with a variable that each found item will have
```
````

### Don't auto-show the file link
````
```dataview
TABLE WITHOUT ID
```
````
or
````
```dataview
LIST WITHOUT ID	
```
````

### Don't include the current file in your search
````
```dataview
WHERE (file.name != this.file.name)	
```
````

### Listing notes with a front-matter due date

*Specifically here listing job applications & when they are due, but this can be repurposed for assignments, projects, anything!*
````
```dataview
TABLE WITHOUT ID // Don't show the file name
	link(file.path, job-title) as "Job",          // Show the job-title from the front matter, label the column Job
	job-with as "With",                           // Show who the job is/would be with
	(due - date(today)) as "Time Left"            // Show how much time there is left to apply
	FROM #Work/Job-Applications
	WHERE date(due) >= date(today) and !submitted // Jobs who have frontmatter: submitted != True and are due in the future/today
	SORT date(due) asc                            // Sort by due date with the closest at the top
```
````

### Notes created today

````
```dataview
LIST
WHERE date(file.cday) = date(today)
```
````
