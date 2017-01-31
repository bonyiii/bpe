export const fetchUserNeeded = (currentUser) => {
  if (Object.keys(currentUser).length === 0 && currentUser.constructor === Object) { return true }
  return false
}
