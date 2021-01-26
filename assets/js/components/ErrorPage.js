import React from 'react'

function ErrorPage(props) {
  return (
    <>
      <h1 className="header-text error">Something went wrong. Check your URL.</h1>
      <a className="button button-extra-large red" href="/">Try Again</a>
    </>
  )
}

export default ErrorPage
