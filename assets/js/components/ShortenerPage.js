import React from 'react'
import UrlShortenerForm from './UrlShortenerForm'

function ShortenerPage({ csrfToken }) {
  return (
    <>
      <h1 className="header-text">Shorty!</h1>
      <UrlShortenerForm csrfToken={csrfToken} />
    </>
  )
}

export default ShortenerPage
