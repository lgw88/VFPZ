lcF = "D:\User\Documents\WeChat Files\wxid_shs1us719wde21\FileStorage\File\2025-05\JsonToCursor.txt"
lcM = FILETOSTR(lcF)
json()
? ">",Json.Parse(lcM)


? json.toCursor(lcM,"AAA")

* ?oVES.fullName ---> "Victor Espina"
* ?oVES.hobbies.Count --> 2
* ?oVES.hobbies.Item[1] --> "Programming"
* ?oVES.Languages.Item[1].id --> "ES"