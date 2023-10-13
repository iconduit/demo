import {dirname, join} from 'path'
import {fileURLToPath} from 'url'
import {readConsumer} from '@iconduit/consumer'

export default readConsumer(join(dirname(fileURLToPath(import.meta.url)), "site.iconduitmanifest"))
