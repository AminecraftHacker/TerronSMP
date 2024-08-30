from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
import sys

# Carica le credenziali
SCOPES = ['https://www.googleapis.com/auth/drive.file']
creds = service_account.Credentials.from_service_account_file('credentials.json', scopes=SCOPES)

# Crea il servizio Google Drive API
service = build('drive', 'v3', credentials=creds)

# Funzione per caricare il file
def upload_file(file_name):
    file_metadata = {'name': file_name}
    media = MediaFileUpload(file_name, resumable=True)
    file = service.files().create(body=file_metadata, media_body=media, fields='id').execute()
    print(f"File ID: {file.get('id')}")

if __name__ == "__main__":
    file_name = sys.argv[1]
    upload_file(file_name)
