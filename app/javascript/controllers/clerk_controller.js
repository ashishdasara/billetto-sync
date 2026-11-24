import { Controller } from "@hotwired/stimulus"

let clerkPromise

function loadScript(src, attributes = {}) {
  return new Promise((resolve, reject) => {
    const script = document.createElement("script")
    script.src = src
    script.crossOrigin = "anonymous"
    Object.entries(attributes).forEach(([name, value]) => script.setAttribute(name, value))
    script.onload = resolve
    script.onerror = () => reject(new Error(`Failed to load ${src}`))
    document.head.appendChild(script)
  })
}

function loadClerk(publishableKey) {
  if (!clerkPromise) {
    clerkPromise = (async () => {
      const decoded = atob(publishableKey.split("_")[2])
      const domain = decoded.slice(0, -1)
      if (!decoded.endsWith("$") || !/^[a-z0-9.-]+$/i.test(domain)) {
        throw new Error("Invalid Clerk publishable key")
      }

      const base = `https://${domain}/npm/@clerk`
      await loadScript(`${base}/ui@1/dist/ui.browser.js`)
      await loadScript(`${base}/clerk-js@6/dist/clerk.browser.js`, {
        "data-clerk-publishable-key": publishableKey
      })
      await window.Clerk.load({ ui: { ClerkUI: window.__internal_ClerkUICtor } })
      return window.Clerk
    })()
  }
  return clerkPromise
}

export default class extends Controller {
  static values = { publishableKey: String }
  static targets = [ "status", "signIn", "signUp", "signOut" ]

  async connect() {
    const connection = this.connection = (this.connection || 0) + 1
    try {
      const clerk = await loadClerk(this.publishableKeyValue)
      if (connection !== this.connection) return

      this.clerk = clerk
      this.render(clerk.isSignedIn)
      this.unsubscribe = clerk.addListener(({ session }) => {
        if (session !== undefined) this.render(Boolean(session))
      }, { skipInitialEmit: true })
    } catch (error) {
      if (connection === this.connection) this.showError(error)
    }
  }

  disconnect() {
    this.connection++
    if (this.unsubscribe) this.unsubscribe()
    this.unsubscribe = null
  }

  render(signedIn) {
    this.statusTarget.textContent = ""
    this.signInTarget.hidden = signedIn
    this.signUpTarget.hidden = signedIn
    this.signOutTarget.hidden = !signedIn
  }

  async signIn() {
    try {
      await this.clerk.openSignIn()
    } catch (error) {
      this.showError(error)
    }
  }

  async signUp() {
    try {
      await this.clerk.openSignUp()
    } catch (error) {
      this.showError(error)
    }
  }

  async signOut() {
    try {
      await this.clerk.signOut()
    } catch (error) {
      this.showError(error)
    }
  }

  showError(error) {
    console.error("Clerk authentication failed:", error)
    this.statusTarget.textContent = "Authentication failed. Please reload and try again."
  }
}
