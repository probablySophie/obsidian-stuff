const secret = "YOUR WIKIPEDIA API KEY SECRET" // WARN: I need to be updated
const num_responses = 3;
const app_name = "Relevant Page Poller"
const contact_email = "YOUR EMAIL ADDRESS" // WARN: I need to be updated




async function wikilink(search_term)
{
	// If we're running this on a blank note, return a call to this function for later use
	if (search_term == "Untitled")
	{
		console.log("Title is untitled.  Returning call to self");
		return "<% tp.user.wikilink(tp.file.title) %>";
	}
	
	let url = 'https://api.wikimedia.org/core/v1/wikipedia/en/search/page?q='+search_term+'&limit='+String(num_responses);
	let response = await fetch( url,
	    {
	        headers: {
	            'Authorization': 'Bearer '+secret,
	            'Api-User-Agent': app_name + " (" + contact_email + ")"
	        }
	    }
	);
	let json = await response.json().catch(console.error);
	let output = ""

	json.pages.forEach(
		(page) => {
			output += (
				"["+page.title+"]" // Page title
				+ "(https://wikipedia.org/wiki/"+page.key+") " // Wiki link with page key
				+ page.description
				+"\n")
		}
	)

	return output;
}
module.exports = wikilink
