import { define } from 'remount'
import ShortenerPage from '../../components/ShortenerPage'
import ShortenedUrlPage from '../../components/ShortenedUrlPage'
import ErrorPage from '../../components/ErrorPage'

define({ 'x-shortener-page': ShortenerPage }, {attributes: ['csrfToken']})
define({ 'x-shortened-url-page': ShortenedUrlPage }, {attributes: ['encodedSlug']})
define({ 'x-error-page': ErrorPage }, {})
