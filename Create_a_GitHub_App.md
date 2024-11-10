How to create a GitHub app:

1. Create App:
   https://github.com/settings/apps
2. Take note of the Client ID (also known as the client_id).
   Example client_id: Za1.a12345678a123ab1a
3. Complete the following and save: App name, Homepage URL, Callback URL: https://0.0.0.0, Request OAuth: Ticked
4. Generate the Client Secret and Take note of the Client Secret (also known as the client_secret).
   Example client_secret: 12ab1ab123a1a1234a1ab1234a1a12ab12a123a12
5. Permissions: Set the permissions you require (in my case to be able to run a clone from a private repo: Read-only Contents and Metadata)
6. Install App: When installing, only select which repo to have access to
7. An invalid Callback URL loads, with a code= in the URL, take note of the code value.
   Example Callback URL: https://0.0.0.0/?code=abc1234a123abcd1a1ab&installation_id=12345678&setup_action=install
   Example code: abc1234a123abcd1a1ab
8. Manually construct the following token request URL, replacing {client_id}, {client_secret} and {code} with what was noted:
   [https://github.com/login/oauth/access_token?client_id={client_id}&client_secret={client_secret}&code={code}&redirect_url=https://0.0.0.0](https://github.com/login/oauth/access_token?client_id=%7Bclient_id%7D&client_secret=%7Bclient_secret%7D&code=%7Bcode%7D&redirect_url=https://0.0.0.0)
   Example token request url:
   https://github.com/login/oauth/access_token?client_id=Za1.a12345678a123ab1a&client_secret=12ab1ab123a1a1234a1ab1234a1a12ab12a123a12&code=abc1234a123abcd1a1ab&redirect_url=https://0.0.0.0
9. A file will be downloaded called 'access_token'. Open it in notepad.
10. Take note of the access_token (between the = and & symbols).
    Example access_token: ghu_ab1aZaZYabcZab1Z1ZYaZ1a1Za1aZa1ZaZYa
11. Example usage to test if it works:
    git clone https://[ghu_ab1aZaZYabcZab1Z1ZYaZ1a1Za1aZa1ZaZYa@github.com](mailto:ghu_ab1aZaZYabcZab1Z1ZYaZ1a1Za1aZa1ZaZYa@github.com)/testuser/testrepo.git

I was able to get the git command to run a clone successfully. I was also unable to access repo I did not grant permission to, so it seems like permissions are working correctly.

(Client ID, Secret, Code & Token used above are examples)

