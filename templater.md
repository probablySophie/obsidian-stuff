
# The Templater Plugin

<!--toc:start-->
- [The Templater Plugin](#the-templater-plugin)
    - [Get the front-matter from a given file as a variable](#get-the-front-matter-from-a-given-file-as-a-variable)
<!--toc:end-->

### Get the front-matter from a given file as a variable

*Specifically for YAML front-matter*
```javascript
<%*
let filename; // The file that the content is coming from

content = await tp.file.include("[[" + filename + "]]");

const yaml = await import("https://unpkg.com/js-yaml?module"); // Import the JS YAML module

// Pull the frontmatter text from the content using regex, then parse it with the YAML module
front_matter = yaml.load(
	content.match(/(?<=-{3}\n)(.*?)(?=\n-{3})/gms)[0], 'utf-8'
);
%>
```
*Unfortunately I can't remember where I found out that you can import and use external JS modules*

