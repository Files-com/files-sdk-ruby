import { createActions } from 'utils/actions'
import Api from 'utils/api'


// Parameters:
//   username - string - Username to sign in as
//   password - string - Password for sign in
//   otp - string - If this user has a 2FA device, provide its OTP or code here.
//   partial_session_id - string - Identifier for a partially-completed login

const ApiCreateSession = params => Api.post(`/sessions`, params)
const createSession = createActions('SESSION_CREATE')


const ApiDeleteSession = params => Api.delete(`/sessions`)
const deleteSession = createActions('SESSION_DELETE')

export {

  createSession, ApiCreateSession,
  deleteSession, ApiDeleteSession,
}
