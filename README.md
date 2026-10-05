# Library Circulation for iPad

An offline library circulation app for your English catalogue (455 books).
It installs on the Home Screen from Safari and keeps borrowers and loans on the iPad.

## What's in this folder

| File | Purpose |
| --- | --- |
| index.html | The whole app, including the book catalogue |
| sw.js | Lets the app open without internet |
| manifest.webmanifest | App name, colours and icons |
| icon-*.png | Home Screen icons |

Upload all of these together. The app won't install properly if any are missing.

## Install it (about 10 minutes, once)

Safari only installs apps from a web address, so the files need to be put online first.
GitHub Pages is free and works from the iPad.

1. On the iPad, unzip the download in the Files app (tap the zip file).
2. In Safari, go to github.com and create a free account.
3. Tap **+** then **New repository**. Name it `circulation`, choose **Public**, and tap **Create repository**.
4. Tap **uploading an existing file**, then choose all the files from the unzipped folder. Tap **Commit changes**.
5. Open the repository's **Settings**, then **Pages**. Under Branch, pick **main** and **/ (root)**, then **Save**.
6. Wait a minute or two. The address appears at the top of the Pages screen, for example
   `https://your-name.github.io/circulation/`.
7. Open that address in Safari, tap **Share**, then **Add to Home Screen**.
8. Open Library Circulation from the Home Screen once while online. After that it works offline.

The app files are public on GitHub, but your borrowers and loans never leave the iPad.

## Adding borrowers

- **One at a time:** the Borrowers tab, **Add**.
- **From a spreadsheet:** open **Loan rules** and tap **Add borrowers from Excel or CSV**. The sheet
  needs a heading row with **Name**, and ideally **Class**, **Phone**, **ID** and **Type**.
  Borrowers already on the iPad, matched by ID or by name and class, have their class and phone
  updated instead of being listed twice. Nobody is ever removed by an import.

Phone numbers are what the message buttons use, so it's worth including that column.

## Adding books by hand

The Books tab has an **Add** button, and so does the Catalogue section of Loan rules. Fill in the
title and accession number; author, call number, shelf code and shelf number are optional. You can
pick an existing category or create one, with an emoji if you like, and it gets its own colour.

Any book's page has **Edit this book** for fixing a title or moving it to another shelf. Books with
no loan history can also be removed there.

## Checking books out and in

**Check out** is its own tab at the bottom. Pick the borrower, then the book by accession number,
title or author, and tap **Issue book**. The date-due slip appears, and **Done** clears the form for
the next person. Below the form sit the most recent loans and a **Check a book back in** button.

Returning and renewing stay on the Desk under **Return or renew**, and tapping any loan anywhere in
the app opens the same check-in screen.

## Printing

Every screen has a **Print** button, which opens the iPad's print sheet. Choose an AirPrint
printer, or pinch outwards on the preview to save the page as a PDF instead. Pages print in plain
black and white, with the library name and the time printed at the top.

| Where | What it prints |
| --- | --- |
| Desk, **Daily report** | Today's counts, overdue books, books due soon, issued and returned today |
| Check out, after issuing | **Print slip**: a date-due slip sized to slip inside the book |
| Return or renew, after check-in | **Print receipt**: a return receipt with any fine |
| Books tab, **Print list** | Exactly the list on screen, with your category, status and search applied |
| A book's page | The book's details and full loan history |
| Borrowers tab, **Print list** | Every borrower with books out, phone and money owed |
| A borrower's page | Their details, books out and borrowing history |
| Loans tab, **Print this list** | The on-loan, overdue or returned list you're looking at |
| Send reminders, **Print notices** | One paper notice per borrower, to hand out in class |
| Stock check report | **Print report**: counts, missing books, and a signature line |
| A past stock check | Its summary and every book currently missing or lost |

## Missing and lost books

Open any book and use **Mark missing** or **Record as lost**, with a note if you want one. Use
missing for a book that isn't where it should be, and lost for one you know has gone, such as one a
borrower can't return. If the book is on loan, recording it ends that loan and keeps any fine
already owed.

Marked books carry a red tag in the Books tab, where **Missing or lost** is a filter. When a book
turns up, open it and tap **It has turned up**; issuing it clears the tag by itself.

## Stock verification

On the Desk, under **Stock check**, tap **Verify the shelves**. Choose the whole library, one shelf
or one category, and start. Then walk the shelves:

- Type or scan an accession number and press Enter, or tap a book in the list, to mark it found.
- Books out on loan count as accounted for, so you aren't hunting for them.
- Anything scanned that isn't in the catalogue, or belongs to another shelf, is noted for you.
- **Pause, finish later** keeps your progress; the Desk shows the check in progress until you
  finish it, even after closing the app.

**Finish the check** gives a report: found, out on loan, back without check-in, missing, and not in
the catalogue. Two of those are worth acting on:

- **Back without check-in** are books sitting on the shelf that the app still thinks are lent out.
  Check them in from the report so nobody is chased or fined.
- **Missing** can be exported to Excel, and saving the report marks those books Missing in the
  catalogue. They show a red Missing tag in the Books tab, where **Missing** is now a filter. If a
  book turns up, open it and tap **It has turned up**; issuing it clears the tag by itself.

### Photos

While a check is running there's a **Photos** section. **Add a photo** opens the camera, or your
photo library, and you can pick several at once. Photograph each shelf as you verify it and you
have a record of what was actually there that day. Tap a photo to see it full size, save it to
Files, or delete it.

Photos stay attached to that check. They appear again in the report and in the past-checks list,
where tapping a check shows its photos.

Photos are stored on the device that took them and are **not** sent through sync or included in
backups, because images are far too big for either. Each one is shrunk to about 1400 pixels before
being saved, so a full shelf-by-shelf record takes very little space, but if you want to keep a
photo beyond the app, save it to Files or your photo library.

Past checks are listed with their dates and how many were missing.

## Messages to borrowers

Safari can't send an SMS by itself, so the app writes the message, fills in the borrower's number
and opens Messages or WhatsApp. You tap send. Nothing goes out without you.

- On the Desk, tap **Send overdue reminders** or **Send due date reminders**. Tap a borrower to
  see their message, then **Open in Messages**, **Open in WhatsApp** or **Copy**. One message
  covers all of that borrower's books.
- A borrower's page has a **Message** button, and the issue slip and return receipt offer one too.
- Borrowers need a phone number on their page. Without one, you can still copy the text.
- Edit the wording in **Loan rules**, under Messages to borrowers, along with your library name and
  country code (+91 by default). Placeholders such as {name}, {books}, {due} and {fine} are filled
  in for you; {is}, {was}, {has} and {it} adjust for one book or several.

For reminders that go out on their own, you'd need a paid SMS service and an internet connection.
Tell me if you want that and I'll explain what it involves.

## Google Drive instead of jsonbin

Sync can keep the online copy in your own Google Drive instead. Under **Sync across your devices**
choose **Google Drive**, paste a Client ID and tap **Connect Google Drive**. Getting the Client ID
is a one-time setup in Google Cloud, explained step by step in **Google-Drive-setup.md**.

Other devices connect with the same Client ID and Google account, and find the existing file by
themselves. Google sign-ins last about an hour; when one runs out, the app shows a **Sign in to
Google** button and catches up as soon as you tap it.

## Syncing your iPad and your phone

The app can keep two or more of your own devices showing the same borrowers, loans and catalogue.
Storage is a free account at **jsonbin.io**; no database or SQL to set up.

1. Go to jsonbin.io in Safari and create a free account.
2. Open your account page and copy the **Master Key**.
3. On the iPad: **Loan rules** → **Sync across your devices** → paste the key → **Start syncing**.
   A **library code** appears. Copy it.
4. On the phone: install the app the same way, paste the same key, paste the library code, then
   **Join this library**.

After that it looks after itself. Changes go up about a second after you make them, and the app
pulls the latest copy when it opens, when you switch back to it, and every half minute while it's
open. The title bar shows the state: **Saved online**, **Saving…**, or **Not saved online** if
something is wrong. There's also a **Sync now** button.

Every device also keeps a full copy on itself, so the desk keeps working when the internet drops
and the changes go up as soon as it returns.

If the same book or borrower is changed on both devices, the later change wins. Deletions are
remembered, so a borrower removed on one device doesn't come back from the other.

**Stop syncing on this device** unhooks that device and leaves its records alone. Keep saving
backups as well; sync is convenience, not a backup.

## Keeping your records safe

Records live inside the installed app on this iPad only. They are lost if you delete the app
from the Home Screen or clear Safari's website data.

- Open **Loan rules** (the sliders icon) and tap **Save a backup**. Choose **Save to Files**,
  ideally to iCloud Drive. Do this weekly. The Desk shows a reminder after 7 days.
- **Restore a backup** in the same screen brings everything back, on this iPad or a new one.
- **Export loans for Excel** saves a CSV of every loan that opens in Excel or Numbers.

## Adding books to the catalogue

You can add new books from a spreadsheet, on the iPad, without internet. Importing adds to the
books already there; the old ones are kept.

1. Put the .xlsx or .csv file in the Files app.
2. In the app, open **Loan rules** (the sliders icon) and tap **Add books from Excel or CSV**.
3. Pick the file. The app says how many books are new and how many are already listed.
4. Tap **Add to catalogue**.

The file can hold only the new books, or the whole catalogue again. A book counts as already
listed when its accession number and title match, or its title and author match. Those books are
refreshed with the details in the file rather than duplicated, so correcting an author or a shelf
code in the spreadsheet and importing again updates the entry.

**Replace catalogue** is the other button on that message. It throws away every book not in the
file, so use it only when the file is your complete catalogue.

What the sheet needs:

- A row of column headings with **Title**, plus **Author** or **Code**. Any heading row in the
  first 30 rows works, so a title and blank rows above it are fine.
- Useful extra columns: **Code** (accession no.), **Category**, **Call No**, **Class No**,
  **Cutter No**, **Shelf No**, **Shelf (1-4)**. Anything else is ignored.
- Rows with no title are skipped. If there are several sheets, the one named Books is used.

Borrowers and loan history are kept. Loans are matched to the new file by accession number and
title; if a book on loan isn't in the new file, the app says so before you confirm, and that loan
is removed. **Back to built-in catalogue** returns to the original 455 books.

Old .xls files aren't readable. Open them in Excel or Numbers and save as .xlsx or CSV first.
Reading .xlsx needs iPadOS 16.4 or newer; on older iPads, use CSV.

## Updating the app later

If you replace index.html with a new version, also open sw.js and change
`circulation-desk-v1` to `circulation-desk-v2` (and so on), then upload both files.
Close and reopen the app twice for the update to appear. Your records are kept.
