import React from 'react'

function UrlShortenerForm({ csrfToken }) {
  return (
    <form method="post">
      <input type="hidden" value={csrfToken} name="_csrf_token" />
      <label htmlFor="url_to_shorten">Enter the URL you'd like shortened</label>
      <input type="url" name="url_to_shorten" required />
      <input className="button button-large submit-button" type="submit" value="Submit" />
    </form>
  )
}

export default UrlShortenerForm
