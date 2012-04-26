<style>code { font-size: 0.8em;}</style>

<%= @intro %>

<hr/>

h2. คู่มือการใช้งาน

* ระบบงานย่อย 1
  * งาน 1 ; หน้าจอ, หน้าจอ, หน้าจอ
  * งาน 2
* ระบบงานย่อย 2
* ระบบงานย่อย 3

<hr/>
h2. คู่มือผู้ดูแลระบบ

h3. โครงสร้างข้อมูล

<%- models= @app.elements["//node[@TEXT='models']"] %>

<%= render :partial=>'main/model.md', :collection=> models.map {|m| m.attributes["TEXT"] } %>

h3. source code

<hr/>

h2. ภาคผนวก

h3. markdown

คู่มือนี้จัดทำขึ้นโดยอัตโนมัติจาก mind map และส่วนต่างๆ ของรหัสโปรแกรม ผู้พัฒนาสามารถเขียนวิธีการใช้งานได้อย่างอิสระ โดยใช้คำสั่ง redcloth ในการเขียนคู่มือประกอบเข้ากับส่วนต่างๆของระบบงาน
