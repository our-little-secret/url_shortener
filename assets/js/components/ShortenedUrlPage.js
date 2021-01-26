import React from 'react'

function ShortenedUrlPage(props) {
  return (
    <>
      <h1 className="header-text">Here's the shortened URL!</h1>
      <p className="url-text">localhost:4000/{props.encodedSlug}</p>
      <a className="button button-large reset-button" href="/">Enter another URL</a>
    </>
  )
}

export default ShortenedUrlPage
