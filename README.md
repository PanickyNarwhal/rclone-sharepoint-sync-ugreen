# rclone-sharepoint-sync-ugreen
A lightweight Bash script used to automate syncing SharePoint Document Libraries to a Ugreen NAS (on UGreenOS) using `rclone`.

## Features
* **Targeted Syncs:** configure specific SharePoint folders to sync to dedicated local NAS directories.
* **Automated:** Uses `--size-only` for faster checks and `--tpslimit 3` to avoid Microsoft API rate limiting.
* **Logging:** Outputs transaction logs to local file.

## Prerequisites
1. **UgreenOS NAS** with SSH access enabled.
2. **[Rclone](https://rclone.org/)** installed and configured on the NAS and a device with a web browser.
3. A working `rclone.conf` file with your SharePoint remote already authenticated.
   If you haven't done any of this, I'll include a quick guide on how to setup Rclone at the bottom.

## Configuration
Before running the script, open `sync_script.sh` and update the following variables to match your environment:

* `DEST`: The root local directory on your NAS where backups will be stored.
* `CONFIG_PATH`: The path to your `rclone.conf` file.
* `LOG_FILE`: The path where you want the sync logs saved.

### Mapping Libraries
Update the `LIBS` array in the script to map your local folder names to their corresponding SharePoint remote paths. Format it as `"LocalFolderName|RemoteName"`.

## Usage
1. Clone this repository on your NAS
2. Make the script executable
3. Edit your LIBS in the script through nano or your text editing tool
4. Run the script

## Automation
To run this script on a schedule, add it to your crontab.

**Installing Rclone onto your Ugreen NAS**
1. SSH into your NAS
2. Install Rclone
  `sudo -v ; curl https://rclone.org/install.sh | sudo bash`
3. verify the install
  `which rclone`
4. On your local PC/Mac, download rclone and run
  `rclone authorize "onedrive"`
5. Log into your Microsoft account and copy your auth key
6. On your NAS SSH terminal start the rclone wizard
  `rclone config`
7. Press n for New Remote
8. Name the remote after your Document Library (e.g, documents) this is what the name will be in the script's LIBS array
9. select whichever storage type is onedrive (For me this was 43)
10. Leave the clint_id and client_secret blank
11. Don't edit the Advanced Config (Just press n for No)
12. Don't use Auto Config as this a headless auth. (Press n)
13. Paste your auth key from your local PC/Mac
14. Choose the Sharepoint option then select whcih site you want to sync.
15. Do this for each of the Document Libraries you want to sync then add them to your LIBS array in the script.
16. To verify the connection, run
    `rclone lsd (remote name):`
