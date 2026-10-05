# Google Drive setup for Library Circulation

This lets the app keep its online copy as one file, `library-circulation.json`, in your own
Google Drive. You do it once; it takes about 20 minutes and is easiest on a computer, though an
iPad works too.

You'll need: your Gmail address, and your app's web address (for example
`https://yourname.github.io`). The app shows that address for you under
**Loan rules → Sync across your devices → Google Drive**, with a Copy button.

## 1. Create a project

1. Go to **console.cloud.google.com** and sign in with the Gmail account you'll use.
2. Accept the terms if asked. No payment details are needed for this.
3. Click the project picker at the top → **New project**. Name it `Library Circulation` →
   **Create**. Make sure it's the selected project afterwards.

## 2. Turn on the Google Drive API

1. In the search bar at the top, type **Google Drive API** and open it.
2. Click **Enable**.

## 3. Set up the sign-in screen

1. Search for **Google Auth Platform** and open it (older screens call this the
   **OAuth consent screen**). Click **Get started**.
2. **App name:** `Library Circulation`. **Support email:** your Gmail. → **Next**.
3. **Audience:** choose **External** → **Next**.
4. **Contact information:** your Gmail → **Next**, agree to the policy → **Create**.
5. Open **Audience** in the left menu. Under **Test users**, click **Add users**, enter your
   Gmail address (and anyone else who will use the app), then **Save**.

Leave the app in **Testing**. That's normal for a private app; it just means only the test
users you listed can sign in.

## 4. Create the Client ID

1. Open **Clients** in the left menu → **Create client**.
2. **Application type:** **Web application**. **Name:** `Library app`.
3. Under **Authorized JavaScript origins**, click **Add URI** and paste your app's address,
   for example `https://yourname.github.io`. Use only the part up to `.io`, with no slash or
   folder name after it. The app's Copy button gives you exactly the right text.
4. Leave **Authorized redirect URIs** empty → **Create**.
5. Copy the **Client ID**. It ends in `.apps.googleusercontent.com`. You don't need the client
   secret.

A new origin can take a few minutes, occasionally longer, to start working at Google's end.

## 5. Connect the app

1. In the app: **Loan rules → Sync across your devices → Google Drive**.
2. Paste the Client ID → **Connect Google Drive**.
3. Google opens a sign-in window. Pick your account. You'll see **"Google hasn't verified this
   app"** — that's expected for a private app in Testing. Tap **Continue**, allow access, and the
   window closes.
4. The title bar changes to **Saved online**, and `library-circulation.json` appears in your
   Google Drive.

**On your phone or another device:** install the app the same way, paste the **same Client ID**,
tap **Connect Google Drive**, and sign in with the **same Google account**. It finds the existing
file by itself; there's no code to copy.

## Living with it

- **Google sign-ins last about an hour.** After that, the title bar shows **Not saved online**
  and the Desk shows a **Sign in to Google** button. Tap it, and the app catches up straight
  away. Your work is never lost in the meantime; it waits on the device.
- **Only that one file.** The app asks only for permission to files it creates, so it can't see
  anything else in your Drive.
- **Don't edit or move the file by hand.** Renaming or trashing it means the next device to
  connect will start a fresh one.
- **Keep saving backups.** Sync copies mistakes to every device too.

## If something goes wrong

| The app says | What to check |
| --- | --- |
| Google didn't allow the sign-in | Your Gmail is listed under **Audience → Test users** |
| Google refused access | The **Google Drive API** is enabled in this project |
| Google rejected the request | The Client ID was pasted in full, ending in `.apps.googleusercontent.com` |
| Sign-in window blocked or closed | Try again and finish the sign-in; allow pop-ups if Safari asks |
| Error about origin or `redirect_uri_mismatch` in the Google window | The JavaScript origin matches your app's address exactly, with no trailing slash |
