# Room

room.gd ==> template resource สำหรับห้อง setting databse และ room logic

การสร้างห้องใข้ Naming เป็น Room001.tres, Room002.tres, Room003.tres ... 

name ชื่อห้อง
description รายละเอียดห้องตอนใช้คำสั่ง "ดู"
notrh , west, east , south, up , down ใช้กำหนดห้องถัดไป

source -> script สำหรับ declare event ใน ห้องนั้นๆ 
ใช้ method ในการ handle event
ใช้การ call method ได้ด้วย Room.exec("eventName")


## todo

[x] integrate ระบบ เข้ากับเกม
[] ทำระบบ "ค้น" เข้ากับห้อง
[] ทำระบบ "ดู ..." ในการดูรายละเอียดอื่นๆ ของห้อง เช่น "ดู เตาผิง"
[] ทำระบบ state ของห้อง เพื่อ record การกระทำในห้อง eg.. เก็บของไปแล้ว
[] ลองทำ custom logic ผ่านไปห้องถ้ดไปต้องมีเงื่อนไขบางอย่าง



